//
//  SummaryView.swift
//  SimpleStoreApp
//
//  Created by Piotr Rola on 05/12/2019.
//  Copyright © 2019 Piotr Rola. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

enum SummaryBuilder {
    static func makeSummaryView(_ context: SummaryContext) -> some View {
    return SummaryView(context)
  }
}

struct SummaryView: View {

    @EnvironmentObject var selectedCurrency: SelectedCurrency

    @ObservedObject
    var viewModel: SummaryViewModel

    init(_ context: SummaryContext) {
        self.viewModel = SummaryViewModel(context)
    }

    var body: some View {
        VStack {
            currencySectionSection
            if viewModel.finalPrice.isEmpty {
                messageSection
            } else {
                summarySection
            }
        }.navigationBarTitle(Text("Summary"), displayMode: .inline)
    }
}

private extension SummaryView {

    var messageSection: some View {
        Section {
            Text(viewModel.message)
        }
    }

    var currencySectionSection: some View {
        Section {
            NavigationLink(destination: viewModel.currenciesView) {
                Text(selectedCurrency.name).padding()
            }
        }
    }

    var summarySection: some View {
        Section {
            Text("FINAL PRICE IS: \(viewModel.finalPrice)")
                .onAppear {
                    self.viewModel.calculateRateForNewCurrency(selectedCurrency: self.selectedCurrency)}
        }
    }
}
