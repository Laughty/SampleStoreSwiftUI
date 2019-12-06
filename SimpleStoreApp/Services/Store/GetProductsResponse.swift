//
//  GetProductsResponse.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct GetProductsResponse: Codable {
    let products: [Product]
}

struct Product: Codable {
    let name: String
    let price: Double
    let baseCurrency: String
}
