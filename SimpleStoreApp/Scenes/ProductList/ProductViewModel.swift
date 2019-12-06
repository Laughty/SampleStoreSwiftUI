//
//  ProductViewModel.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import SwiftUI

class  ProductViewModel: Identifiable {

    let id = UUID()

    let product: Product
    var rate: Double

    init(product: Product, rate: Double = 1.0) {
        self.product = product
        self.rate = rate
    }

    var name: String {
        return self.product.name
    }

    var baseCurrency: String {
        return self.product.baseCurrency
    }

    var price: String {
        return String(format: "%.02f", product.price * rate)
    }

    var numericPrice: Double {
        return product.price * rate
    }
}
