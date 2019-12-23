//
//  NativeClient.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 01/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

final class NativeClient: ServiceProtocol {

    func performRequest<T: Codable>(_ reqeust: Request, results: @escaping (Result<T>) -> Void) {
        let url = reqeust.buildURL()

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                results(.error(error))
                return
            }

            let response = try? JSONDecoder().decode(T.self, from: data)
            if let response = response {
                DispatchQueue.main.async {
                    results(.success(response))
                }
            }
        }.resume()
    }
}
