//
//  Result.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 01/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

enum Result<T: Codable> {
    case success(T)
    case error(Error?)
}
