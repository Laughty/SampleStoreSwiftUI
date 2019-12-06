//
//  RequestProtocol.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 01/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

enum HTTPRequestType {
    case GET, POST
}

protocol Request {
    var endpoint: String { get set }
    var requestType: HTTPRequestType { get set }
    var params: [String: String]? { get set }
    var body: Data? { get set }

    func buildURL() -> URL
}

extension Request {

    func buildURL() -> URL {
        var urlString: String = API.baseURL + endpoint
        if let params = params, requestType == .GET {
            urlString += "?"
            for (key, value) in params {
                urlString += "\(key)=\(value)"
            }
         }
        guard let url = URL(string: urlString) else {
            fatalError("Not able to create url from: \(urlString)")}
        return url
    }
}
