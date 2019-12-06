//
//  GetPairsDataRequest.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct GetPairsDataRequest: Request {

    init(_ pairName: String) {
        self.params = ["pairs": pairName]
    }
    var endpoint: String = "api/live"
    var requestType: HTTPRequestType = .GET
    var params: [String : String]?
    var body: Data?
}
