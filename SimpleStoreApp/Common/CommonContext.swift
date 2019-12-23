//
//  CommonContext.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 02/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

protocol CommonContext {
    var apiClient: ServiceProtocol { get }
}

final class DefaultContext: CommonContext {

    let apiClient: ServiceProtocol = NativeClient()
}

final class TestingContext: CommonContext {
    let apiClient: ServiceProtocol = MockClient()
}
