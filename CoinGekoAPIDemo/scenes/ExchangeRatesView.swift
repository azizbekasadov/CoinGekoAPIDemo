//
//  ExchangeRatesView.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 20.11.2025.
//

import SwiftUI

struct ExchangeRatesView: View {
    @StateObject private var viewModel = ExchangeRatesViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Section("Swaps") {
                List(viewModel.exchangeRates, rowContent: { row in
                    Text(row.name)
                })
                .listStyle(.inset)
                .padding(.horizontal, -16)
            }
            .padding(16)
        }
        .task {
            await viewModel.getExchangeRates()
        }
    }
}

#Preview {
    ExchangeRatesView()
        .frame(width: 720, height: 480)
}
