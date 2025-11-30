//
//  ExchangeRatesRepository.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import Foundation
import CoinGekoAPI

protocol ExchangeRatesRepositoryProto {
    func loadList() async throws -> [ExchangeData]
}

final class ExchangeRatesRepository: ExchangeRatesRepositoryProto {
    private let remote: (any ExchangeRatesRemoteDataSourceProto)
    private let local: (any ExchangesRouteLocalDataSourceProto)
    
    init(
        remote: (any ExchangeRatesRemoteDataSourceProto),
        local: (any ExchangesRouteLocalDataSourceProto)
    ) {
        self.remote = remote
        self.local = local
    }
    
    func loadList() async throws -> [ExchangeData] {
        if let localData = try await local.request(with: .exchangesList), !localData.isEmpty {
            return try parseLoadedData(localData)
        } else {
            let remoteData = try await remote.request(with: .exchangesList)
            try local.saveJSONToCache(remoteData, for: "exchange-list")
            return try parseLoadedData(remoteData)
        }
    }
    
    private func parseLoadedData(_ data: Data) throws -> [ExchangeData] {
        try JSONDecoder().decode([ExchangeData].self, from: data)
    }
}
