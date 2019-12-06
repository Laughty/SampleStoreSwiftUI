//
//  ProductListView.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct ProductListView : View {

    @ObservedObject
    var viewModel: ProductListViewModel

    @ObservedObject
    var productsInCart: ShoppingCartItems

    init(_ commonContext: CommonContext) {
        let productsInCart = ShoppingCartItems()
        self.viewModel = ProductListViewModel(commonContext, productsInCart: productsInCart)
        self.productsInCart = productsInCart
    }

    var body: some View {
        NavigationView {
            VStack {
                currencySectionSection
                productListSection
            }.navigationBarItems(leading:
                NavigationLink(destination: viewModel.summaryView) {
                    Text("Checkout")
                }
                ,trailing:
                NavigationLink(destination: viewModel.cartView.environmentObject(viewModel.productsInCart)) {
                    Text("CART: \(viewModel.productsInCart.items.count)")
                }
            ).navigationBarTitle(Text("Awesome Store"), displayMode: .inline)
        }
    }
}

private extension ProductListView {

    var currencySectionSection: some View {
        Section {
            NavigationLink(destination: viewModel.currenciesView
                .environmentObject(viewModel.selectedCurrency)
                .environmentObject(viewModel.productsInCart)) {
                Text(viewModel.selectedCurrency.name).padding()
            }
        }
    }

    var productListSection: some View {
        Section {
            List(viewModel.productsList) { product in
                HStack {
                    Text(product.name).padding()
                    Text(product.price).padding()
                }.onTapGesture {
                    self.viewModel.productsInCart.items.append(product)
                }
            }.onAppear{self.viewModel.calculateRateForNewCurrency()}
        }
    }
}

