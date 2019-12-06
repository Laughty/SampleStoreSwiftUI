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
    let selectedCurrency: String
    let productsInCart: [ProductViewModel]

    init(_ commonContext: CommonContext, productsInCart: [ProductViewModel], baseCurrency: String, selectedCurrency: String){
        self.commonContext = commonContext
        self.baseCurrency = baseCurrency
        self.productsInCart = productsInCart
        self.selectedCurrency = selectedCurrency
    }
}

final class SummaryViewModel: ObservableObject {

    private let forexService: ForexExchangeRateService
    private let commonContext: CommonContext
    private var baseCurrency: String
    private let productsInCart: [ProductViewModel]

    var selectedCurrency = SelectedCurrency()

    @Published var finalPrice: String = ""

    init(_ context: SummaryContext) {
        self.forexService = ForexExchangeRateService(apiClient: context.commonContext.apiClient)
        self.commonContext = context.commonContext
        self.baseCurrency = context.baseCurrency
        self.productsInCart = context.productsInCart
        self.selectedCurrency.name = context.selectedCurrency
        updateFinalPrice()
    }


    func calculateRateForNewCurrency(selectedCurrency: SelectedCurrency) {
        updateFinalPrice()
        guard selectedCurrency.name != baseCurrency else {
            return
        }

        let pairName = baseCurrency+selectedCurrency.name
        forexService.getExchangeRates(GetPairsDataRequest(pairName), results: { [weak self] (currencyRate, error) in
            guard error == nil else { return }
            if let currencyRate = currencyRate {
                self?.calculatePricesWithRate(rate: currencyRate[pairName]?.rate)
            }
        })
    }

    private func calculatePricesWithRate(rate: Double?) {
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
