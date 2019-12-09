//
//  CurrencyViewModel.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 06/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import SwiftUI
import Foundation

struct CurrenciesContext {
    let baseCurrency: String
    let commonContext: CommonContext

    init(_ commonContext: CommonContext, baseCurrency: String) {
        self.commonContext = commonContext
        self.baseCurrency = baseCurrency
    }
}

final class CurrenciesViewModel: ObservableObject {

    private let emptyStateMessage = "Please wait... currencies are loading"

    private let baseCurrency: String
    private let forexService: ForexExchangeRateServiceProtocol

    @Published var currencies = [CurrencyViewModel]()
    @Published var message: String = ""

    init(_ context: CurrenciesContext,
         forexService: ForexExchangeRateServiceProtocol? = nil) {
        self.forexService = forexService == nil ? ForexExchangeRateService(apiClient: context.commonContext.apiClient) : forexService!
        baseCurrency = context.baseCurrency
        message = emptyStateMessage
        fetchCurrencies()
    }

    private func fetchCurrencies() {
        forexService.getAvailablePairs(GetAvailablePairsRequest(), results: { [weak self] (currencies, error) in
            guard error == nil else {
                self?.message = error!
                return
            }

            if let currencies = currencies {
                self?.updateCurreciesList(with: currencies)
            }
        })
    }

    private func updateCurreciesList(with currencies: [String]) {
        self.currencies = currencies.filter{ $0.contains(baseCurrency) }
            .map{ CurrencyViewModel($0.replacingOccurrences(of: baseCurrency, with: "")) }
        self.currencies.insert(CurrencyViewModel(baseCurrency), at: 0)
    }
}
