//
//  AccountVerificationCoordinatorView.swift
//  Coinstar
//
//  Created by Akshay Matre on 22/10/26.
//

import SwiftUI

struct AccountVerificationCoordinatorView: View {
    @State private var coordinator: AccountVerificationCoordinator

    init(container: AppContainer, eventSink: any AppFlowEventSink) {
        _coordinator = State(
            initialValue: AccountVerificationBuilder.makeCoordinator(container: container, eventSink: eventSink)
        )
    }

    var body: some View {
        @Bindable var coordinator = coordinator

        NavigationStack(path: $coordinator.path) {
            AccountVerificationView(coordinator: coordinator)
                .navigationDestination(for: AccountVerificationRoute.self) { route in
                    destination(for: route)
                }
        }
    }

    @ViewBuilder
    private func destination(for route: AccountVerificationRoute) -> some View {
        switch route {
            case .otpVerification(let fullNumber):
                OTPVerificationPlaceholderView(fullNumber: fullNumber) {
                    coordinator.completeVerification()
                }
        }
    }
}

private struct OTPVerificationPlaceholderView: View {
    let fullNumber: String
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            ContentUnavailableView(
                "Verify OTP",
                systemImage: "lock.shield",
                description: Text("Enter the OTP sent to \(fullNumber). OTP verification screen will be added next.")
            )

            Button("Continue", action: onContinue)
                .buttonStyle(.borderedProminent)
        }
        .padding(24)
    }
}
