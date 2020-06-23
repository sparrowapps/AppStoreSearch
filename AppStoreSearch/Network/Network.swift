//
//  Network.swift
//  AppStoreSearch
//
//  Created by sparrow on 2020/06/20.
//  Copyright © 2020 sparrowapps. All rights reserved.
//

import Foundation
import RxSwift

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

    func requestSearch(by requestURL: URL?) -> Observable<AppResponse> {
        return Observable.create { observer in
            guard let url = requestURL else {
                observer.onError(NetworkError.url)
                return Disposables.create()
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, _  in
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(AppResponse.self, from: data)
                    observer.onNext(result)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.jsonDecode)
                }
            }
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
    
    func requestImage(urlString: String) -> Observable<Data> {
        return Observable.create { observer in
            guard let url = URL(string: urlString) else {
                observer.onError(NetworkError.url)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return  }
                observer.onNext(data)
                observer.onCompleted()
            }
            task.resume()
            
            return Disposables.create(with: task.cancel)
        }
    }
}
