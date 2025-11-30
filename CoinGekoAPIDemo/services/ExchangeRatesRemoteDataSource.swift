//
//  ClientAPIService.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 20.11.2025.
//

import Foundation
import CoinGekoAPI

protocol ExchangeRatesRemoteDataSourceProto {
    func request(
        with route: ExchangesRoute
    ) async throws -> Data
}

final class ExchangeRatesRemoteDataSource: ExchangeRatesRemoteDataSourceProto {
    private let service: CoinGekoAPIContract
    
    init(coinGekoAPI: CoinGekoAPIContract = CoinGeckoApi()) {
        self.service = coinGekoAPI
    }
    
    @MainActor
    func request(with route: ExchangesRoute) async throws -> Data {
        return try await service.request(with: route)
    }
}
