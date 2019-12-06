//
//  GetAvailablePairsResponse.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 03/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

struct GetAvailablePairsResponse: Codable {
    let message: String
    let supportedPairs: [String]
    let code: Int
}
