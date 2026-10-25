//
//  AccountVerificationCoordinator.swift
//  Coinstar
//
//  Created by Akshay Matre on 22/10/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class AccountVerificationCoordinator {
    var path: [AccountVerificationRoute] = []
    let viewModel: AccountVerificationViewModel

    private weak var eventSink: (any AppFlowEventSink)?

    init(
        viewModel: AccountVerificationViewModel,
        eventSink: (any AppFlowEventSink)? = nil
    ) {
        self.viewModel = viewModel
        self.eventSink = eventSink
    }

    func navigate(to route: AccountVerificationRoute) {
        path.append(route)
    }

    func handleOtpRequested() {
        guard let fullNumber = viewModel.requestedFullNumber else { return }
        navigate(to: .otpVerification(fullNumber: fullNumber))
    }

    func completeVerification() {
        eventSink?.send(.accountVerificationCompleted)
    }
}
