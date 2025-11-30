//
//  LocalGekoCachingService.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import Foundation
import CoinGekoAPI

protocol ExchangesRouteLocalDataSourceProto {
    @MainActor
    func request(
        with route: ExchangesRoute
    ) async throws -> Data?
    
    func saveJSONToCache(_ data: Data, for key: String) throws
}

final class ExchangesRouteLocalDataSource: ExchangesRouteLocalDataSourceProto {
    
    @MainActor
    func request(with route: ExchangesRoute) async throws -> Data? {
        do {
            let fileURL = try cacheFileURL(for: "exchange-list")
            guard FileManager.default.fileExists(atPath: fileURL.path) else {
                return nil
            }
            
            return try Data(contentsOf: fileURL)
        } catch {
            debugPrint("Failed to load cached JSON:", error)
            return nil
        }
    }
    
    func saveJSONToCache(_ data: Data, for key: String) throws {
        let fileURL = try cacheFileURL(for: key)
        
        try data.write(to: fileURL, options: .atomic)
    }
    
    private func cacheFileURL(for key: String) throws -> URL {
        let cachesDir = try FileManager.default.url(
            for: .cachesDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
        )

        return cachesDir.appendingPathComponent("\(key).json")
    }
}
