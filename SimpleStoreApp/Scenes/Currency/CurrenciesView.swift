//
//  CurrencyView.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 06/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

enum CurrenciesBuilder {
    static func makeCurrenciesView(_ context: CurrenciesContext) -> some View {
    return CurrenciesView(context)
  }
}

struct CurrenciesView : View {

    @EnvironmentObject var selectedCurrency: SelectedCurrency

    @ObservedObject
    var viewModel: CurrenciesViewModel

    init(_ context: CurrenciesContext) {
        self.viewModel = CurrenciesViewModel(context)
    }

    var body: some View {
        VStack {
            selectedCurrencySection
            currenciesListSection
        }.navigationBarTitle(Text("Currencies"), displayMode: .inline)
    }
}

extension CurrenciesView {

    var selectedCurrencySection: some View {
        Section {
            Text(self.selectedCurrency.name).padding()
        }
    }

    var currenciesListSection: some View {
        Section {
            List(viewModel.currencies) { currency in
                Text(currency.name).padding().onTapGesture {
                    self.selectedCurrency.name = currency.name
                }
            }
        }
    }
}

