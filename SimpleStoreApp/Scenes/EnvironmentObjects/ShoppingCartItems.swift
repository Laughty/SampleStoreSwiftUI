//
//  ShoppingCartItems.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 06/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import SwiftUI

final class ShoppingCartItems: ObservableObject {

    @Published var items = [ProductViewModel]()
}
