//
//  PurchaseProductsRequest.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct PurchaseProductsRequest: Request {

    init(_ products: [ProductOrder]) {
        body = try! JSONEncoder().encode(products)
    }

    var endpoint: String = "api/products/buy"
    var requestType: HTTPRequestType = .POST
    var params: [String : String]?
    var body: Data?
}

struct ProductOrder: Codable {
    let name: String
    let quantity: Int
}
