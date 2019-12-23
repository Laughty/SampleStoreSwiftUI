//
//  GetAvailablePairsRequest.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct GetAvailablePairsRequest: Request {
    var endpoint: String = "api/live"
    var requestType: HTTPRequestType = .GET
    var params: [String: String]?
    var body: Data?
}
