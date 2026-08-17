//
//  ContentView.swift
//  Coinstar
//
//  Created by Akshay Matre on 31/07/26.
//

import SwiftUI

struct RootView: View {
    
    private let appContainer: AppContainer
    @State private var appFlowCoordinator: AppFlowCoordinator
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
        _appFlowCoordinator = State(
            initialValue: AppFlowCoordinator(container: appContainer)
        )
    }
    
    var body: some View {
        Group {
            if !appFlowCoordinator.hasStarted {
                ProgressView()
            } else {
                flowView
            }
        }
        .task {
            appFlowCoordinator.start()
        }
    }
    
    @ViewBuilder
    private var flowView: some View {
        switch appFlowCoordinator.flow {
            case .onboarding:
                OnbaordingCoordinatorView(
                    container: appContainer,
                    eventSink: appFlowCoordinator
                )
                
            case .accountVerification:
//                AccountVerificationCoordinatorView(
//                    eventSink: appFlowCoordinator
//                )
                PlaceholderFlowView(
                    title: "Account verification",
                    message: "Account Verification flow will be added next."
                )
                
            case .registration:
                PlaceholderFlowView(
                    title: "Registration",
                    message: "Registration flow will be added next."
                )
                
            case .login:
                PlaceholderFlowView(
                    title: "Login",
                    message: "Login flow will be added next."
                )
                
            case .home:
                PlaceholderFlowView(
                    title: "Home",
                    message: "Home flow will be added next."
                )
        }
    }
    
}

private struct PlaceholderFlowView: View {
    let title: String
    let message: String

    var body: some View {
        ContentUnavailableView(
            title,
            systemImage: "arrow.triangle.branch",
            description: Text(message)
        )
    }
}

