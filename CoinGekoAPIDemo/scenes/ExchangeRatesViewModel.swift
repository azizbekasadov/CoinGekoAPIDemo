//
//  ExchangeRatesViewModel.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 20.11.2025.
//

import Foundation
import Combine
import CoinGekoAPI

struct ExchangeData: Identifiable, Decodable {
    let id: String
    let name: String
}

final class ExchangeRatesViewModel: ObservableObject {
    @Published var exchangeRates: [ExchangeData] = []
    
    private let repo: ExchangeRatesRepositoryProto
    
    init(repo: ExchangeRatesRepositoryProto) {
        self.repo = repo
    }
    
    func getExchangeRates() async {
        do {
            self.exchangeRates = try await repo.loadList()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
