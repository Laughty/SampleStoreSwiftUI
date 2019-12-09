//
//  SimpleStoreAppUITests.swift
//  SimpleStoreAppUITests
//
//  Created by Piotr Rola on 30/11/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import XCTest

class SimpleStoreAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        app = XCUIApplication()
        app.launchArguments.append("STORE_UI_TESTING")
        app.launch()
    }

    override func tearDown() {}

    func testAddRemoveCartItems() {
        let tablesQuery = app.tables
        let staticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["0.95"]/*[[".cells.staticTexts[\"0.95\"]",".staticTexts[\"0.95\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        staticText.tap()
        staticText.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Eggs"]/*[[".cells.staticTexts[\"Eggs\"]",".staticTexts[\"Eggs\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(app.navigationBars["Awesome Store"].buttons["CART: 3"].waitForExistence(timeout: 0.5))

        app.navigationBars["Awesome Store"].buttons["CART: 3"].tap()
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 1)
        cell.staticTexts["Tap to remove"].tap()
        app.navigationBars["Cart"].buttons["Awesome Store"].tap()

        XCTAssert(app.navigationBars["Awesome Store"].buttons["CART: 2"].waitForExistence(timeout: 0.5))
    }

    func testChangeCurrency() {
        app.buttons["USD"].tap()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["EUR"].tap()
        app.navigationBars["Currencies"].buttons["Awesome Store"].tap()

        XCTAssert(tablesQuery.staticTexts["0.72"].waitForExistence(timeout: 0.5))
        XCTAssert(app.buttons["EUR"].waitForExistence(timeout: 0.5))
    }

    func testShowSummaryAndChangeCurrency() {

        let app = XCUIApplication()
        let tablesQuery = app.tables
        let peasStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Peas"]/*[[".cells.staticTexts[\"Peas\"]",".staticTexts[\"Peas\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        peasStaticText.tap()
        peasStaticText.tap()

        let eggsStaticText = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Eggs"]/*[[".cells.staticTexts[\"Eggs\"]",".staticTexts[\"Eggs\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eggsStaticText.tap()
        eggsStaticText.tap()

        app.navigationBars["Awesome Store"].buttons["Checkout"].tap()
        XCTAssert(app.staticTexts["FINAL PRICE IS: 6.10"].waitForExistence(timeout: 0.5))

        app.buttons["USD"].tap()
        app.staticTexts["EUR"].tap()
        app.navigationBars["Currencies"].buttons["Summary"].tap()
        XCTAssert(app.buttons["EUR"].waitForExistence(timeout: 0.5))
        XCTAssert(app.staticTexts["FINAL PRICE IS: 4.64"].waitForExistence(timeout: 0.5))

        app.navigationBars["Summary"].buttons["Awesome Store"].tap()

        XCTAssert(app.buttons["EUR"].waitForExistence(timeout: 0.5))
        XCTAssert(tablesQuery.staticTexts["0.72"].waitForExistence(timeout: 0.5))
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
