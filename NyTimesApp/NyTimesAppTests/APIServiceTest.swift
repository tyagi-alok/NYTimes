//
//  APIServiceTest.swift
//  NyTimesAppTests
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import XCTest
@testable import NyTimesApp

class APIServiceTest: XCTestCase {

    var mockService:PopularArticlesService?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockService = PopularArticlesService(apiClient: APIClient())
    }

    override func tearDownWithError() throws {
        mockService = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_fetch_popular_articles() {
        // Given A apiservice
        let mockService = self.mockService!

        // When fetch popular photo
        let expect = XCTestExpectation(description: "callback")
        mockService.getPopularArtciles { (result) in
            expect.fulfill()
            switch result{
            case .success(let data):
                XCTAssert(data.resultsNumber ?? 0 > 0, "")
            case .failure(_):
                XCTAssert(false, "Failed to get response")
            }
        }
        wait(for: [expect], timeout: 10.0)
    }

}
