//
//  AppFlowCoordinator.swift
//  Coinstar
//
//  Created by Akshay Matre on 17/08/26.
//
import Foundation
import Observation

@MainActor
@Observable
final class AppFlowCoordinator: AppFlowEventSink {
    private(set) var flow: AppFLow = .onboarding
    private(set) var hasStarted = false

    let container: AppContainer

    private let launchStateStore: AppLaunchStateStoring

    init(
        container: AppContainer,
        launchStateStore: AppLaunchStateStoring = AppLaunchStateStore()
    ) {
        self.container = container
        self.launchStateStore = launchStateStore
    }

    func start() {
        guard !hasStarted else { return }
        hasStarted = true
        flow = flow(for: launchStateStore.load())
    }

    func send(_ event: AppFlowEvent) {
        switch event {
        case .onboardingCompleted:
            launchStateStore.markOnboardingCompleted()
            flow = .accountVerification

        case .accountVerificationCompleted:
            launchStateStore.markAccountVerificationCompleted()
            flow = .registration

        case .registrationCompleted:
                launchStateStore.markRegistrationCompleted()
            flow = .login

        case .loginCompleted:
                launchStateStore.markLoginCompleted()
            flow = .home
        }
    }

    private func flow(for state: AppLaunchState) -> AppFLow {
        if !state.onbobardingCompleted {
            return .onboarding
        }

        if !state.acountVerificationCompleted {
            return .accountVerification
        }

        if !state.registrationCompleted {
            return .registration
        }

        if !state.loginCompleted {
            return .login
        }

        return .home
    }
}
