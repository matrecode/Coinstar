//
//  AccountVerificationBuilder.swift
//  Coinstar
//
//  Created by Akshay Matre on 22/10/26.
//

import Foundation
import SwiftUI

@MainActor
enum AccountVerificationBuilder {

    static func makeView(container: AppContainer) -> some View {
        let coordinator = makeCoordinator(
            container: container,
            eventSink: PreviewAppFlowEventSink()
        )
        return AccountVerificationView(coordinator: coordinator)
    }

    static func makeCoordinator(container: AppContainer, eventSink: any AppFlowEventSink) -> AccountVerificationCoordinator {
        let countryRepository: CountryRepositoryProtocol = LocalCountryRepositoryImpl()

        let otpRepository: OTPRepositoryProtocol
        if let baseUrl = container.configuration.environment.apiBasUrl {
            otpRepository = RemoteOtpRepositoryImpl(
                baseURL: baseUrl,
                networkClient: container.networkClient
            )
        } else {
            otpRepository = LocalOtpRepositoryImpl()
        }

        let getCountriesUseCase = GetCountriesUseCase(repository: countryRepository)
        let validatePhoneNumberUseCase = ValidatePhoneNumberUseCase()
        let requestOTPUseCase = RequestOtpUseCase(repository: otpRepository)

        let viewModel = AccountVerificationViewModel(
            getCountriesUseCase: getCountriesUseCase,
            validatePhoneNumberUseCase: validatePhoneNumberUseCase,
            requestOTPUseCase: requestOTPUseCase
        )

        return AccountVerificationCoordinator(
            viewModel: viewModel,
            eventSink: eventSink
        )
    }
}

@MainActor
private final class PreviewAppFlowEventSink: AppFlowEventSink {
    func send(_ event: AppFlowEvent) {}
}
