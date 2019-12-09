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
                if viewModel.productsList.isEmpty {
                    messageSection
                } else {
                    currencySectionSection
                    productListSection
                }
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

    var messageSection: some View {
        Section {
            Text(viewModel.message)
        }
    }

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
                    Text("Tap to add").padding().foregroundColor(.green)
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

