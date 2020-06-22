//
//  Network.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/20.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import Foundation
import RxSwift

enum HTTP: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: LocalizedError {
    case url
    case response
    case statusCode(Int)
    case responseData
    case jsonDecode
    
    var errorDescription: String? {
        switch self {
        case .url:
            return "URL error"
        case .response:
            return "response error"
        case .statusCode(let code):
            return "http response error code: \(code)"
        case .responseData:
            return "response data error"
        case .jsonDecode:
            return "JSON decode error"
        }
    }
}

class Network {
    static var shared = Network()
    private init() {}
    func requestImage(urlString: String) -> Observable<Data> {
        return Observable.create { [unowned self] observer in
            guard let url = self.requsetURL(urlString) else {
                observer.onError(NetworkError.url)
                return Disposables.create()
            }
            
            let task = self.request(with: url, method: .get) { responseData, requsetError in
                if let error = requsetError {
                    observer.onError(error)
                    
                } else if let data = responseData {
                    observer.onNext(data)
                    observer.onCompleted()
                } else {
                    observer.onError(NetworkError.responseData)
                }
            }
            
            return Disposables.create(with: task.cancel)
        }
    }
    
    private func requsetURL(_ urlString: String, with parameters: [String : String]? = nil) -> URL? {
        var urlComponents = URLComponents(string: urlString)
        
        if let _parameters = parameters {
            let query = _parameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
            
            urlComponents?.queryItems = query
        }
        return urlComponents?.url
    }
    
    private func request(with url: URL, method: HTTP, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url, timeoutInterval: 30)
        request.httpMethod = method.rawValue
        
        URLSession.shared.configuration.waitsForConnectivity = true
        let task = URLSession.shared.dataTask(with: request) { responseData, urlResponse, requsetError in
            var error: Error? = nil
            defer {
                completion(responseData, error)
            }
            
            guard requsetError == nil else {
                error = requsetError
                return
            }
            
            guard let response = urlResponse as? HTTPURLResponse else {
                error = NetworkError.response
                return
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                error = NetworkError.statusCode(response.statusCode)
                return
            }
        }
        task.resume()
        
        return task
    }
}
