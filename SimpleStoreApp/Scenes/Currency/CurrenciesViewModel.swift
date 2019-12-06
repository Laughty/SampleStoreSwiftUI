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
    }

    func fetchCurrencies(selectedCurrency: String) {
        forexService.getAvailablePairs(GetAvailablePairsRequest(), results: { [weak self] (currencies, error) in
            guard let strSelf = self, error == nil else { return }
            if let currencies = currencies {
                self?.currencies = currencies.filter{ $0.contains(strSelf.baseCurrency) }
                    .map{ CurrencyViewModel($0.replacingOccurrences(of: strSelf.baseCurrency, with: "")) }
                    .filter{ !$0.name.contains(selectedCurrency) }
            }
        })
    }
}
