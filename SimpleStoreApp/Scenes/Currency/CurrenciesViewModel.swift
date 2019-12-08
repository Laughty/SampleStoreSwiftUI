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

    private let baseCurrency: String
    private let forexService: ForexExchangeRateService

    @Published var currencies = [CurrencyViewModel]()

    init(_ context: CurrenciesContext) {
        forexService = ForexExchangeRateService(apiClient: context.commonContext.apiClient)
        baseCurrency = context.baseCurrency
        fetchCurrencies()
    }

    private func fetchCurrencies() {
        forexService.getAvailablePairs(GetAvailablePairsRequest(), results: { [weak self] (currencies, error) in
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
