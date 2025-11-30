//
//  ExchangeRatesViewFactory.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 01.12.2025.
//

import Foundation

struct ExchangeRatesViewFactory {
    
    static func make() -> ExchangeRatesView {
        let remote = ExchangeRatesRemoteDataSource()
        let local = ExchangesRouteLocalDataSource()
        
        let repo = ExchangeRatesRepository(
            remote: remote,
            local: local
        )
        
        let viewModel = ExchangeRatesViewModel(repo: repo)
        
        let view = ExchangeRatesView(
            viewModel: viewModel
        )
        
        return view
    }
    
}
