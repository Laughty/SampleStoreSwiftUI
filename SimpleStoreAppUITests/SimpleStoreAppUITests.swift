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

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {

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
