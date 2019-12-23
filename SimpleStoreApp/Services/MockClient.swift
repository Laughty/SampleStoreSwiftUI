//
//  MockClient.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 06/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

final class MockClient: ServiceProtocol {
    func performRequest<T>(_ reqeust: Request,
                           results: @escaping (Result<T>) -> Void) where T: Decodable, T: Encodable {

        switch reqeust {
        case is GetProductsRequest:
            print("GetProductsRequest")
            var products: [Product] = []
            products.append(Product(name: "Peas", price: 0.95, baseCurrency: "USD"))
            products.append(Product(name: "Eggs", price: 2.10, baseCurrency: "USD"))
            products.append(Product(name: "Milk", price: 1.30, baseCurrency: "USD"))
            products.append(Product(name: "Beans", price: 0.73, baseCurrency: "USD"))
            let response = GetProductsResponse(products: products)
            guard let result = Result<GetProductsResponse>.success(response) as? Result<T> else { return }
            results(result)
        case is GetPairsDataRequest:
            let currencyRate = CurrencyRate(rate: 1.313336, timestamp: TimeInterval())
            let pairsRateDictionary = ["EURUSD": currencyRate]
            let response = GetPairsDataResponse(rates: pairsRateDictionary, code: 1001)
            guard let result = Result<GetPairsDataResponse>.success(response) as? Result<T> else { return }
            results(result)
        case is GetAvailablePairsRequest:
            let pairNames = ["EURUSD", "GBPUSD", "CADUSD", "EURGBP"]
            let response = GetAvailablePairsResponse(message: "", supportedPairs: pairNames, code: 1001)
            guard let result = Result<GetAvailablePairsResponse>.success(response) as? Result<T> else { return }
            results(result)
        default:
            print("Unhadled Reques")
        }
    }
}
