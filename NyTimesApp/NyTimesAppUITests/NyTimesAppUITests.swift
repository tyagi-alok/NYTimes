//
//  NyTimesAppUITests.swift
//  NyTimesAppUITests
//
//  Created by Alok Tyagi on 11/11/20.
//  Copyright © 2020 Alok. All rights reserved.
//

import XCTest

class NyTimesAppUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testArticlesList(){
        
        //fetching table view from the accessibility Identifier and
        let firstCell = app.tables["articlesListingTableView"].cells.firstMatch
        if firstCell.waitForExistence(timeout: 7), firstCell.exists {
            firstCell.tap()
            sleep(1)
            app.navigationBars["NyTimesApp.PopularArticlesDetailView"].buttons["Back"].tap()
             sleep(1)
            
            //scrolling up to table
            app.tables["articlesListingTableView"].swipeUp()
            sleep(1)
            
            //scrolling down to table
            app.tables["articlesListingTableView"].swipeDown()
        }
    }
}
