//
//  PopularArticlesViewModelTest.swift
//  NyTimesAppTests
//
//  Created by Alok Tyagi on 12/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import XCTest
@testable import NyTimesApp

class PopularArticlesViewModelTest: XCTestCase {

    var mockViewModelObj:PopularArticlesListViewModel?
    var mockApiServiceObj:MockApiService?
    var DEFAULT_URL = "https://static01.nyt.com/images/2020/11/12/upshot/12up-vote-count/12up-vote-count-thumbStandard.jpg"

    override func setUpWithError() throws {
        super.setUp()
        mockApiServiceObj = MockApiService()
        mockViewModelObj = PopularArticlesListViewModel(apiService: mockApiServiceObj!)
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockApiServiceObj = nil
        mockViewModelObj = nil
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
    
    func testFetchArticlesCellsSuccessfully() {
        mockViewModelObj?.initFetch()
        
        // Given a fetch with a success
        mockApiServiceObj?.fetchSuccess()
        
        switch mockApiServiceObj?.completeClosure {
        case .success(let data):
            XCTAssertEqual("OK", data.status)
        default:
             XCTFail()
        }

    }
    
    func testFetchArticlesCellsFail() {
        
        // Given a failed fetch with a certain failure
        let error = ErrorResult.custom(string: "Failed")
        
        mockViewModelObj?.initFetch()
        
        mockApiServiceObj?.fetchFail(error:error)
        
        switch mockApiServiceObj?.completeClosure {
        case .failure(_):
            XCTAssert(true)
        default:
            XCTFail()
        }
        
    }
    
    func testFetchArticlesCellsWithoutImage() {

        mockViewModelObj?.initFetch()
        
        // Given a fetch with no images
        mockApiServiceObj?.fetchArtcilesWithoutImages()

        switch mockApiServiceObj?.completeClosure {
        case .success(let data):
            mockViewModelObj?.cellViewModels = data
            XCTAssert(mockViewModelObj?.cellViewModels?.articles[0].media.count ?? 0 == 0)
        default:
             XCTFail()
        }

    }
    
    func testFetchArticlesCellsWithImage() {

        mockViewModelObj?.initFetch()
        
        // Given a fetch with images
        mockApiServiceObj?.fetchArtcilesWithImages()

        switch mockApiServiceObj?.completeClosure {
        case .success(let data):
            mockViewModelObj?.cellViewModels = data
            XCTAssert(mockViewModelObj?.cellViewModels?.articles[0].media.count ?? 0 > 0)
        default:
             XCTFail()
        }

    }
    
    func testFetchDataWithNoArticles() {

        mockViewModelObj?.initFetch()
        
        // Given a fetch with no articles
        mockApiServiceObj?.fetchSuccessfullyWithNoArticles()

        switch mockApiServiceObj?.completeClosure {
        case .success(let data):
            mockViewModelObj?.cellViewModels = data
            XCTAssert(mockViewModelObj?.cellViewModels?.articles.count ?? 0 == 0)
        default:
             XCTFail()
        }

    }
}

class MockApiService: APIServiceProtocol {
   
    var isFetchPopularArticlesCalled = false
    var completeClosure : PopularArticlesService.GetFriendsResult?
    
    func getPopularArtciles(_ completion: @escaping ((Result<PopularArticlesModel, ErrorResult>) -> Void)) {
        isFetchPopularArticlesCalled = true
         completeClosure = .success(PopularArticlesModel.with())
    }
    
    
    func fetchSuccess() {
        completeClosure = .success(PopularArticlesModel.with())
    }

    func fetchFail(error: ErrorResult) {
        completeClosure = .failure(error)
    }
    
    func fetchSuccessfullyWithNoArticles() {
        completeClosure = .success(PopularArticlesModel(status: "Ok", resultsNumber: 10,
        articles: []))
    }
    
    func fetchArtcilesWithImages() {
        completeClosure = .success(PopularArticlesModel(status: "Ok", resultsNumber: 10,
                                        articles: [Articles(publishedDate: "10-11-2020", title: "title", abstract: "abstract", byline: "byLine", id: 11234567,
                                        media:[Media(mediaMetadata: [Metadata(imageUrl:DEFAULT_URL)])])]))
    }
    func fetchArtcilesWithoutImages() {
        completeClosure = .success(PopularArticlesModel(status: "Ok", resultsNumber: 10,
                                        articles: [Articles(publishedDate: "10-11-2020", title: "title", abstract: "abstract", byline: "byLine", id: 11234567,
                                        media:[])]))
    }

    
}
