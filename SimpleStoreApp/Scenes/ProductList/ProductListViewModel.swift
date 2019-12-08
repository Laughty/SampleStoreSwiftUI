//
//  ProductsViewModel.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import SwiftUI

final class ProductListViewModel: ObservableObject {

    private let storeService: StoreServiceProtocol
    private let forexService: ForexExchangeRateService
    private let commonContext: CommonContext
    private var baseCurrency: String = "USD"

    private var products = [Product]() {
        didSet {
            productsList = products.map({ProductViewModel(product: $0)})
        }
    }

    @Published var productsList = [ProductViewModel]()
    @Published var productsInCart = ShoppingCartItems()
    @Published var numberOfProductsInCart: Int = 0

    init(_ commonContext: CommonContext) {
        self.storeService = StoreService(apiClient: commonContext.apiClient)
        self.forexService = ForexExchangeRateService(apiClient: commonContext.apiClient)
        self.commonContext = commonContext
        fetchProducts()
    }

    func addProductToCart(_ product: ProductViewModel) {
        productsInCart.items.append(product)
        numberOfProductsInCart = productsInCart.items.count
    }

    func updateProductsInCartCount() {
        numberOfProductsInCart = productsInCart.items.count
    }

    func calculateRateForNewCurrency(selectedCurrency: SelectedCurrency) {
        guard let baseCurrency = products.first?.baseCurrency else {
            return
        }

        let pairName = baseCurrency+selectedCurrency.name
        print(pairName)
        forexService.getExchangeRates(GetPairsDataRequest(pairName), results: { [weak self] (currencyRate, error) in
            guard error == nil else { return }
            if let currencyRate = currencyRate {
                self?.calculatePricesWithRate(rate: currencyRate[pairName]?.rate)
            }
        })
    }

    private func fetchProducts() {
        storeService.getProducts(GetProductsRequest(), results: { [weak self] (products, error) in
            guard error == nil else { return }
            if let products = products {
                guard let strSelf = self else { return }
                strSelf.products = products.products
                strSelf.baseCurrency = products.products.first?.baseCurrency ?? "USD"
            }
        })
    }

    private func calculatePricesWithRate(rate: Double?) {
        guard let rate = rate else { return }
        productsList = products.map({ ProductViewModel(product: $0, rate: rate) })
        productsInCart.items.forEach { $0.rate = rate }
    }
}

extension ProductListViewModel {

    var currenciesView: some View {
        return CurrenciesBuilder.makeCurrenciesView(CurrenciesContext(commonContext,
                                                                      baseCurrency: baseCurrency))
    }

    var cartView: some View {
        return CartBuilder.makeCartView().environmentObject(productsInCart)
    }

    var summaryView: some View {
        let context = SummaryContext(commonContext,
                                     productsInCart: productsInCart.items,
                                     baseCurrency: baseCurrency)
        return SummaryBuilder.makeSummaryView(context)
    }

}


