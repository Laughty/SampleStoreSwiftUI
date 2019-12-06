//
//  GetPairsDataResponse.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct GetPairsDataResponse: Codable {
    let rates: [String: CurrencyRate]
    let code: Int
}

struct CurrencyRate: Codable {
    let rate: Double
    let timestamp: TimeInterval
}
