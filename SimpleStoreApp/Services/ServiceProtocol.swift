//
//  ServiceProtocol.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 05/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

protocol ServiceProtocol {

    func performRequest<T: Codable>(_ reqeust: Request, results: @escaping (Result<T>) -> Void)
}
