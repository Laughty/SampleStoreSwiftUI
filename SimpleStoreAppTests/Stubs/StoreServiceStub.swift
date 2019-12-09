//
//  StoreServiceStub.swift
//  SimpleStoreAppTests
//
//  Created by Piotr Rola on 08/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation
@testable import SimpleStoreApp

enum ServiceStoreTestingConfiguration {
    case error
    case empty
    case successful
}

class StoreServiceStub: StoreServiceProtocol {

    var testingConfiguration: ServiceStoreTestingConfiguration = .successful

    func getProducts(_ request: GetProductsRequest, results: @escaping (GetProductsResponse?, String?) -> ()) {
        switch testingConfiguration {
        case .error:
            results(nil, "Bad error")
        case .empty:
            let products: [Product] = []
            results(GetProductsResponse(products: products), "No resutls")
        case .successful:
            var products: [Product] = []
            products.append(Product(name: "Peas", price: 0.95, baseCurrency: "USD"))
            products.append(Product(name: "Eggs", price: 2.10, baseCurrency: "USD"))
            products.append(Product(name: "Milk", price: 1.30, baseCurrency: "USD"))
            products.append(Product(name: "Beans", price: 0.73, baseCurrency: "USD"))
            results(GetProductsResponse(products: products), nil)
        }
    }
}
