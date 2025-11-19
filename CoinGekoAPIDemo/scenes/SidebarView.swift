//
//  SidebarView.swift
//  CoinGekoAPIDemo
//
//  Created by Azizbek Asadov on 20.11.2025.
//

import SwiftUI

enum SidebarViewType: String, Identifiable, CaseIterable, Hashable {
    var id: String {
        return self.rawValue
    }
    
    case exchangeRates
    case companies
    case coins
    
    var title: String {
        switch self {
        case .companies:
            return "Companies"
        case .exchangeRates:
            return "Exchange Rates"
        case .coins:
            return "Coins"
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
}

struct SidebarView: View {
    @State private var section: SidebarViewType = .exchangeRates
    
    var body: some View {
        List(
            SidebarViewType.allCases,
            selection: $section
        ) { row in
            Text(row.title)
        }
        .listStyle(.sidebar)
    }
}
