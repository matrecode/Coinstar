//
//  ContentView.swift
//  Coinstar
//
//  Created by Akshay Matre on 31/07/26.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        switch coordinator.state.flow {
        case .onboarding:
            Text("Onboarding Coordinator")
        case .registration:
            Text("Registration Coordinator")
        }
    }
}

#Preview {
    RootView(coordinator: AppCoordinator())
}
