//
//  ForexServiceStub.swift
//  SimpleStoreAppTests
//
//  Created by Piotr Rola on 08/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation
@testable import SimpleStoreApp

enum ServiceForexTestingConfiguration {
    case error
    case successful
}

final class ForexServiceStub: ForexExchangeRateServiceProtocol {

    var testingConfiguration: ServiceForexTestingConfiguration = .successful

    func getAvailablePairs(_ request: GetAvailablePairsRequest,
                           results: @escaping ([String]?, String?) -> Void) {
        switch testingConfiguration {
        case .error:
            results(nil, "Bad error")
        case .successful:
            let pairNames = ["EURUSD", "GBPUSD", "CADUSD", "EURGBP"]
            results(pairNames, nil)
        }
    }

    func getExchangeRates(_ request: GetPairsDataRequest,
                          results: @escaping ([String: CurrencyRate]?, String?) -> Void) {
        switch testingConfiguration {
        case .error:
            results(nil, "Bad error")
        case .successful:
            let currencyRate = CurrencyRate(rate: 1.313336, timestamp: TimeInterval())
            let pairsRateDictionary = ["EURUSD": currencyRate]
            results(pairsRateDictionary, nil)
        }
    }
}
