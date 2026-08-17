//
//  AppLaunchStateStore.swift
//  Coinstar
//
//  Created by Akshay Matre on 16/08/26.
//

import Foundation

struct AppLaunchState {
    var onbobardingCompleted: Bool
    var acountVerificationCompleted: Bool
    var registrationCompleted: Bool
    var loginCompleted: Bool
    
    static let initial = AppLaunchState(
        onbobardingCompleted: false,
        acountVerificationCompleted: false,
        registrationCompleted: false,
        loginCompleted: false
    )
}

protocol AppLaunchStateStoring {
    func load() -> AppLaunchState
    func markOnboardingCompleted()
    func markAccountVerificationCompleted()
    func markRegistrationCompleted()
    func markLoginCompleted()
}

private enum AppLaunchStateUsrDefaultsKeys {
    static let onbobardingCompleted = "coinstar.onbaordingCompleted"
    static let acountVerificationCompleted = "coinstar.accountVerficationCompleted"
    static let registrationCompleted = "coinstar.registrationCompleted"
    static let loginCompleted = "coinstar.loginCompleted"
}

@MainActor
final class AppLaunchStateStore: AppLaunchStateStoring {
    private let coinstarDefaults: UserDefaults
    
    init(coinstarDefaults: UserDefaults = .standard) {
        self.coinstarDefaults = coinstarDefaults
    }
    
    func load() -> AppLaunchState {
        AppLaunchState(
            onbobardingCompleted: coinstarDefaults.bool(forKey: AppLaunchStateUsrDefaultsKeys.onbobardingCompleted),
            acountVerificationCompleted: coinstarDefaults.bool(forKey: AppLaunchStateUsrDefaultsKeys.acountVerificationCompleted),
            registrationCompleted: coinstarDefaults.bool(forKey: AppLaunchStateUsrDefaultsKeys.registrationCompleted),
            loginCompleted: coinstarDefaults.bool(forKey: AppLaunchStateUsrDefaultsKeys.loginCompleted)
        )
    }

    func markOnboardingCompleted() {
        coinstarDefaults.set(true, forKey: AppLaunchStateUsrDefaultsKeys.onbobardingCompleted)
    }

    func markAccountVerificationCompleted() {
        coinstarDefaults.set(true, forKey: AppLaunchStateUsrDefaultsKeys.acountVerificationCompleted)
    }

    func markRegistrationCompleted() {
        coinstarDefaults.set(true, forKey: AppLaunchStateUsrDefaultsKeys.registrationCompleted)
    }

    func markLoginCompleted() {
        coinstarDefaults.set(true, forKey: AppLaunchStateUsrDefaultsKeys.loginCompleted)
    }

    
}
