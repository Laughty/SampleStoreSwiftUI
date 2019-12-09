//
//  StoreService.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

protocol StoreServiceProtocol {

    func getProducts(_ request: GetProductsRequest, results: @escaping (GetProductsResponse?, String?) -> ())
}

class StoreService: StoreServiceProtocol {
    let apiClient: ServiceProtocol

    init(apiClient: ServiceProtocol) {
        self.apiClient = apiClient
    }

    func getProducts(_ request: GetProductsRequest, results: @escaping (GetProductsResponse?, String?) -> ()) {

        var products: [Product] = []
        products.append(Product(name: "Peas", price: 0.95, baseCurrency: "USD"))
        products.append(Product(name: "Eggs", price: 2.10, baseCurrency: "USD"))
        products.append(Product(name: "Milk", price: 1.30, baseCurrency: "USD"))
        products.append(Product(name: "Beans", price: 0.73, baseCurrency: "USD"))

        results(GetProductsResponse(products: products), nil)
    }
}
