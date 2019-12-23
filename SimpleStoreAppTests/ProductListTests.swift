//
//  ProductListTests.swift
//  SimpleStoreAppTests
//
//  Created by Piotr Rola on 08/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import XCTest
@testable import SimpleStoreApp

final class ProductListTests: XCTestCase {

    var viewModel: ProductListViewModel!
    let storeServiceStub = StoreServiceStub()
    let forexServiceStub = ForexServiceStub()

    override func setUp() {
        storeServiceStub.testingConfiguration = .successful
        viewModel = ProductListViewModel(TestingContext(),
                                         storeService: storeServiceStub,
                                         forexService: forexServiceStub)
    }

    override func tearDown() {}

    func testFetchProducts() {

        XCTAssert(viewModel.productsList.count == 4)
        XCTAssert(viewModel.message == "Please wait... products are loading")
    }

    func testFetchProductsMapping() {

        XCTAssert(viewModel.productsList.first?.rate == 1.0)
        XCTAssert(viewModel.productsList.first?.price == "0.95")
        XCTAssert(viewModel.productsList.first?.name == "Peas")
        XCTAssert(viewModel.productsList.first?.baseCurrency == "USD")
        XCTAssert(viewModel.productsList.first?.numericPrice == 0.95)

    }

    func testAddProductToCart() {

        viewModel.addProductToCart(viewModel.productsList[0])
        viewModel.addProductToCart(viewModel.productsList[2])
        viewModel.addProductToCart(viewModel.productsList[2])

        XCTAssert(viewModel.productsInCart.items.count == 3)
        XCTAssert(viewModel.numberOfProductsInCart == 3)
    }

    func testFetchProductsFailure() {
        storeServiceStub.testingConfiguration = .error
        viewModel = ProductListViewModel(TestingContext(),
                                         storeService: storeServiceStub,
                                         forexService: forexServiceStub)
        XCTAssert(viewModel.productsList.count == 0)
        XCTAssert(viewModel.message == "Bad error")
    }

    func testFetchProductsEmpty() {
        storeServiceStub.testingConfiguration = .empty
        viewModel = ProductListViewModel(TestingContext(),
                                         storeService: storeServiceStub,
                                         forexService: forexServiceStub)
        print(viewModel.productsList.count)
        XCTAssert(viewModel.productsList.count == 0)
        XCTAssert(viewModel.message == "No resutls")
    }

    func testSuccefulPricesRecalculationSameCurrency() {

        viewModel.addProductToCart(viewModel.productsList[0])
        viewModel.calculateRateForNewCurrency(selectedCurrency: SelectedCurrency())

        XCTAssert(viewModel.productsList[0].price == "0.95")
        XCTAssert(viewModel.productsInCart.items[0].price == "0.95")
        print(viewModel.productsList[0].price)

    }

    func testSuccefulPricesRecalculationDifferentCurrency() {

        viewModel.addProductToCart(viewModel.productsList[0])
        let selectedCurrency = SelectedCurrency()
        selectedCurrency.name = "EUR"
        viewModel.calculateRateForNewCurrency(selectedCurrency: selectedCurrency)

        XCTAssert(viewModel.productsList[0].price == "0.72")
        XCTAssert(viewModel.productsInCart.items[0].price == "0.72")
    }

    func testFailureRecalculation() {

        viewModel.addProductToCart(viewModel.productsList[0])
        let selectedCurrency = SelectedCurrency()
        selectedCurrency.name = "EUR"
        forexServiceStub.testingConfiguration = .error
        viewModel.calculateRateForNewCurrency(selectedCurrency: selectedCurrency)

        XCTAssertFalse(viewModel.productsList[0].price == "0.72")
        XCTAssertFalse(viewModel.productsInCart.items[0].price == "0.72")
        XCTAssert(viewModel.message == "Bad error")
    }

}
