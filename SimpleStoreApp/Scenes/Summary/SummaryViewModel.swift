//
//  SummaryViewModel.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 05/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import SwiftUI

struct SummaryContext {

    let commonContext: CommonContext
    let baseCurrency: String
    let productsInCart: [ProductViewModel]

    init(_ commonContext: CommonContext, productsInCart: [ProductViewModel], baseCurrency: String) {
        self.commonContext = commonContext
        self.baseCurrency = baseCurrency
        self.productsInCart = productsInCart
    }
}

final class SummaryViewModel: ObservableObject {

    private let forexService: ForexExchangeRateServiceProtocol
    private let commonContext: CommonContext
    private var baseCurrency: String
    private let productsInCart: [ProductViewModel]

    @Published var finalPrice: String = ""
    @Published var message: String = ""

    init(_ context: SummaryContext,
         forexService: ForexExchangeRateServiceProtocol? = nil) {
        self.forexService = forexService == nil ?
            ForexExchangeRateService(apiClient: context.commonContext.apiClient) : forexService!
        self.commonContext = context.commonContext
        self.baseCurrency = context.baseCurrency
        self.productsInCart = context.productsInCart
        updateFinalPrice()
    }

    func calculateRateForNewCurrency(selectedCurrency: SelectedCurrency) {
        updateFinalPrice()
        guard selectedCurrency.name != baseCurrency else {
            return
        }

        let pairName = selectedCurrency.name+baseCurrency
        forexService.getExchangeRates(GetPairsDataRequest(pairName), results: { [weak self] (currencyRate, error) in
            guard error == nil else {
                self?.finalPrice = ""
                self?.message = error!
                return }
            if let currencyRate = currencyRate {
                self?.calculatePrices(with: currencyRate[pairName]?.rate)
            }
        })
    }

    private func calculatePrices(with rate: Double?) {
        guard let rate = rate else { return }
        productsInCart.forEach { $0.rate = rate }
        updateFinalPrice()
    }

    private func updateFinalPrice() {
        var price: Double = 0.0
        productsInCart.forEach { price += $0.numericPrice }
        finalPrice = String(format: "%.02f", price)
    }
}

extension SummaryViewModel {

    var currenciesView: some View {
        return CurrenciesBuilder.makeCurrenciesView(CurrenciesContext(commonContext, baseCurrency: baseCurrency))
    }
}
