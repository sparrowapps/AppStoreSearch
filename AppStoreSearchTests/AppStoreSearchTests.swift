//
//  AppStoreSearchTests.swift
//  AppStoreSearchTests
//
//  Created by Marcos Griselli on 14/07/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import XCTest
import Network
import RxSwift

@testable import AppStoreSearch

class AppStoreSearchTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testNetworkSearch() {
        let encodedTerm = "카카오뱅크"
            .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = URL(string: "https://itunes.apple.com/search?term=\(encodedTerm ?? String())&entity=software,iPadSoftware&limit=10&country=kr&lang=ko_kr")
        Network.shared.requestSearch(by: url)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { response in
                XCTAssertEqual(response.results.count,  10)
                XCTAssertEqual(response.results[0].name,  "카카오뱅크 - 같지만 다른 은행")
            }).disposed(by: disposeBag)
    }
    
    func testNetworkRequestImage() {
        Network.shared.requestImage(urlString: "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/7a/9c/6e/7a9c6e68-6f25-3aa4-703f-5763aaf78731/source/512x512bb.jpg")
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .retry(2)
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: {  imageData in
                XCTAssert(imageData.count == 11228)
            }).disposed(by: disposeBag)
    }
    
    func testNetworkDetail() {
        let id = 1258016944
        let url = URL(string: "https://itunes.apple.com/lookup?id=\(id)&country=kr&lang=ko_kr")
        Network.shared.requestSearch(by: url)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { response in
                //XCTAssertEqual(response.results.count,  10)
                XCTAssertEqual(response.results[0].name,  "카카오뱅크 - 같지만 다른 은행")
            }).disposed(by: disposeBag)
    }
    
    func testSearchHistory() {
        SearchHistory.insert("카카오뱅크")
        let terms = SearchHistory.get()
        XCTAssertEqual(terms.first, "카카오뱅크")
        
        var count = 0
        for t in terms {
            if t == "카카오뱅크" {
                count = count + 1
            }
        }
        XCTAssertEqual(count, 1)
        
        XCTAssert(terms.count < 100)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
