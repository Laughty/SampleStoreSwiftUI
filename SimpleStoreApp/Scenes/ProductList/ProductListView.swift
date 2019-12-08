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

    @EnvironmentObject var selectedCurrency: SelectedCurrency

    @ObservedObject
    var viewModel: ProductListViewModel

    init(_ commonContext: CommonContext) {
        self.viewModel = ProductListViewModel(commonContext)
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
                NavigationLink(destination: viewModel.cartView) {
                    Text("CART: \(viewModel.numberOfProductsInCart)")
                }
            ).navigationBarTitle(Text("Awesome Store"), displayMode: .inline)
        }
    }
}

private extension ProductListView {

    var currencySectionSection: some View {
        Section {
            NavigationLink(destination: viewModel.currenciesView) {
                Text(selectedCurrency.name).padding()
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
                    self.viewModel.addProductToCart(product)
                }
            }.onAppear{
                self.viewModel.calculateRateForNewCurrency(selectedCurrency: self.selectedCurrency)
                self.viewModel.updateProductsInCartCount()
            }
        }
    }
}

