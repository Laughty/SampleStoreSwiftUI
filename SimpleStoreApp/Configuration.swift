//
//  Configuration.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 01/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum API {

    private static let httpsString = "https://"
    private static let baseURLkey = "API_BASE_URL"

    static var baseURL: String {
        let value: String? = try? Configuration.value(for: baseURLkey)
        return httpsString + (value ?? "")
    }

}
