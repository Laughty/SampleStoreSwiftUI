//
//  MockClient.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 06/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

final class MockClient: ServiceProtocol {
    func performRequest<T>(_ reqeust: Request, results: @escaping (Result<T>) -> ()) where T : Decodable, T : Encodable {
        // return mocked responses

        switch reqeust {
        case is GetProductsRequest:
            print("GetProductsRequest")
        default:
            print("Unhadled Reques")
        }
    }


}
