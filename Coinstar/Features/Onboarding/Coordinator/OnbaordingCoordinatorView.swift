//
//  OnbaordingCoordinatorView.swift
//  Coinstar
//
//  Created by Akshay Matre on 16/08/26.
//

import SwiftUI

struct OnbaordingCoordinatorView: View {
    @State private var coordinator: OnboardingCoordinator
    
    init(container: AppContainer, eventSink: any AppFlowEventSink) {
        _coordinator = State(
            initialValue: OnboardingBuilder
                .makeCoordinator(container: container, eventSink: eventSink)
        )
    }
    
    var body: some View {
        @Bindable var coordinator = coordinator
        
        NavigationStack(path: $coordinator.path){
            OnboardingView(coordinator: coordinator)
                .navigationDestination(for: OnboardingRoute.self){ route in
                    
                }
        }
    }
    
    @ViewBuilder
    private func destination(for route: OnboardingRoute) -> some View {
        switch route {
            case .permission:
                PermissionsPlaceholderView()
        }
    }
}

private struct PermissionsPlaceholderView: View {
    var body: some View {
        ContentUnavailableView(
            "Permissions",
            systemImage: "checkmark.shield",
            description: Text("Permission screens can be added here later.")
        )
    }
}

