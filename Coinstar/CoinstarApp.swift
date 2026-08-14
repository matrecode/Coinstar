//
//  CoinstarApp.swift
//  Coinstar
//
//  Created by Akshay Matre on 31/07/26.
//

import SwiftUI

@main
struct CoinstarApp: App {
    @State private var appContainer = AppContainer()
    var body: some Scene {
        WindowGroup {
            RootView(appContainer: appContainer)
        }
    }
}
