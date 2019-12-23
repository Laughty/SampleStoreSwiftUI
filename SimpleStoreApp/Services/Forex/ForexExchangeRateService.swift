//
//  ForexExchangeRateService.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 01/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

protocol ForexExchangeRateServiceProtocol {

    func getAvailablePairs(_ request: GetAvailablePairsRequest, results: @escaping ([String]?, String?) -> Void)
    func getExchangeRates(_ request: GetPairsDataRequest,
                          results: @escaping ([String: CurrencyRate]?, String?) -> Void)
}

final class ForexExchangeRateService: ForexExchangeRateServiceProtocol {

    let apiClient: ServiceProtocol

    init(apiClient: ServiceProtocol) {
        self.apiClient = apiClient
    }

    func getAvailablePairs(_ request: GetAvailablePairsRequest, results: @escaping ([String]?, String?) -> Void) {
        let responseClosure: (Result<GetAvailablePairsResponse>) -> Void = { response in
            switch response {
            case .success(let result):
                results(result.supportedPairs, nil)
            case .error(let error):
                print(error.debugDescription)
                results(nil, error?.localizedDescription)
            }
        }

        apiClient.performRequest(request, results: responseClosure)
    }

    func getExchangeRates(_ request: GetPairsDataRequest,
                          results: @escaping ([String: CurrencyRate]?, String?) -> Void) {
        let responseClosure: (Result<GetPairsDataResponse>) -> Void = { response in
            switch response {
            case .success(let result):
                results(result.rates, nil)
            case .error(let error):
                print(error.debugDescription)
                results(nil, error?.localizedDescription)
            }
        }

        apiClient.performRequest(request, results: responseClosure)
    }

}
