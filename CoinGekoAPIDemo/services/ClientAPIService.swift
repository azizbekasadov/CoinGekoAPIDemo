//
//  ClientAPIService.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 20.11.2025.
//

import Foundation
import CoinGekoAPI

protocol ClientAPIServiceProto {
    typealias Route = CoinGekoAPI.Route
    
    func request(
        with route: Route
    ) async throws -> Data
}

final class ClientAPIService: NSObject, ClientAPIServiceProto {
    private let coinGekoAPI: CoinGekoAPIContract
    
    init(coinGekoAPI: CoinGekoAPIContract = CoinGeckoApi()) {
        self.coinGekoAPI = coinGekoAPI
    }
    
    @MainActor
    func request(
        with route: Route
    ) async throws -> Data {
        try await coinGekoAPI.request(with: route)
    }
}
