//
//  CurrencyViewModel.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 06/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import SwiftUI

class  CurrencyViewModel: Identifiable {

    let id = UUID()
    let name: String

    init(_ name: String) {
        self.name = name
    }
}
