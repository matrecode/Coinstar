//
//  CoinstarApp.swift
//  Coinstar
//
//  Created by Akshay Matre on 31/07/26.
//

import SwiftUI

@main
struct CoinstarApp: App {
    @StateObject var appCordinator = AppCoordinator()
    var body: some Scene {
        WindowGroup {
            RootView(coordinator: appCordinator)
        }
    }
}
