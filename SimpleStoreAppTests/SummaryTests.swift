//
//  SummaryTests.swift
//  SimpleStoreAppTests
//
//  Created by Piotr Rola on 08/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import XCTest
@testable import SimpleStoreApp

class SummaryTests: XCTestCase {

    var viewModel: SummaryViewModel!
    let forexServiceStub = ForexServiceStub()

    override func setUp() {
        forexServiceStub.testingConfiguration = .successful
        viewModel = SummaryViewModel(SummaryContext(TestingContext(),
                                                    productsInCart: getMockProductsViewModel(),
                                                    baseCurrency: "USD"),
                                     forexService: forexServiceStub)
    }

    override func tearDown() {}

    func testFinalPriceCalculation() {
        XCTAssert(viewModel.finalPrice == "5.08")
    }

    func testUpdateFinalPriceSuccessful() {
        let selectedPrice = SelectedCurrency()
        selectedPrice.name = "EUR"
        viewModel.calculateRateForNewCurrency(selectedCurrency: selectedPrice)
        XCTAssert(viewModel.finalPrice == "3.87")
    }

    func testUpdateFinalPriceFailure() {
        forexServiceStub.testingConfiguration = .error
        viewModel = SummaryViewModel(SummaryContext(TestingContext(),
                                                    productsInCart: getMockProductsViewModel(),
                                                    baseCurrency: "USD"),
                                     forexService: forexServiceStub)
        let selectedPrice = SelectedCurrency()
        selectedPrice.name = "EUR"
        viewModel.calculateRateForNewCurrency(selectedCurrency: selectedPrice)
        XCTAssert(viewModel.message == "Bad error")
    }

    func testUpdateFinalPriceSameCurrency() {
        let selectedPrice = SelectedCurrency()
        viewModel.calculateRateForNewCurrency(selectedCurrency: selectedPrice)
        XCTAssert(viewModel.finalPrice == "5.08")
    }

    private func getMockProductsViewModel() -> [ProductViewModel] {
        var products: [Product] = []
        products.append(Product(name: "Peas", price: 0.95, baseCurrency: "USD"))
        products.append(Product(name: "Eggs", price: 2.10, baseCurrency: "USD"))
        products.append(Product(name: "Milk", price: 1.30, baseCurrency: "USD"))
        products.append(Product(name: "Beans", price: 0.73, baseCurrency: "USD"))
        return products.map { ProductViewModel(product: $0) }
    }
}
