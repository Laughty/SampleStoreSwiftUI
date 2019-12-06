//
//  CartView.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 05/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

enum CartBuilder {
    static func makeCartView() -> some View {
        return CartView()
  }
}

struct CartView : View {

    @EnvironmentObject var productsInCart: ShoppingCartItems

    var body: some View {
        NavigationView {
            VStack {
            productListSection
            }.navigationBarTitle(Text("Cart"), displayMode: .inline)
        }
    }
}

private extension CartView {

    var productListSection: some View {
        Section {
            List(productsInCart.items) { product in
                HStack {
                    Text(product.name).padding()
                    Text(product.price).padding()
                    Text("Tap to remove").padding()
                }.onTapGesture {
                    if let index = self.productsInCart.items.firstIndex(where: { $0.id == product.id }) {
                        self.productsInCart.items.remove(at: index)
                    }
                }
            }
        }
    }
}


