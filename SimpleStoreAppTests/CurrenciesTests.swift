//
//  CurrenciesTests.swift
//  SimpleStoreAppTests
//
//  Created by Piotr Rola on 08/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import XCTest
@testable import SimpleStoreApp

class CurrenciesTests: XCTestCase {

    var viewModel: CurrenciesViewModel!
    let forexServiceStub = ForexServiceStub()

    override func setUp() {
        forexServiceStub.testingConfiguration = .successful
        viewModel = CurrenciesViewModel(CurrenciesContext(TestingContext(), baseCurrency: "USD"),
                                        forexService: forexServiceStub)
    }

    override func tearDown() {}

    func testFetchCurrenciesSuccessful() {
        XCTAssert(viewModel.currencies.count == 4)
        XCTAssert(viewModel.message == "Please wait... currencies are loading")
    }

    func testFetchCurrenciesMapping() {
        XCTAssert(viewModel.currencies[0].name == "USD")
        XCTAssert(viewModel.currencies[1].name == "EUR")
    }

    func testFetchCurrenciesFailure() {
        forexServiceStub.testingConfiguration = .error
        viewModel = CurrenciesViewModel(CurrenciesContext(TestingContext(), baseCurrency: "USD"),
                                        forexService: forexServiceStub)
        XCTAssert(viewModel.currencies.count == 0)
        XCTAssert(viewModel.message == "Bad error")
    }
}
