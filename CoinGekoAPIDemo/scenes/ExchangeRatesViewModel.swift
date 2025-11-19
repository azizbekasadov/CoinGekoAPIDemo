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
    
    private let service: ClientAPIServiceProto
    
    init(service: ClientAPIServiceProto = ClientAPIService()) {
        self.service = service
    }
    
    func getExchangeRates() async {
        do {
            let data = try await service.request(with: ExchangesRoute.exchangesList)
            self.exchangeRates = try JSONDecoder().decode([ExchangeData].self, from: data)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
