// CoinGekoAPIDemoApp

import SwiftUI

@main
struct CoinGekoAPIDemoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                SidebarView()
            } detail: {
                ExchangeRatesViewFactory.make()
            }

        }
    }
}
