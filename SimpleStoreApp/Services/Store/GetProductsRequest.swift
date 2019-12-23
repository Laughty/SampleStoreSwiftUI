//
//  GetProductsRequest.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct GetProductsRequest: Request {
    var endpoint: String = "api/products"
    var requestType: HTTPRequestType = .GET
    var params: [String: String]?
    var body: Data?
}
