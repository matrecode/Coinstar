//
//  OnboardingBuilder.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import SwiftUI

@MainActor
enum OnboardingBuilder {
    
    static func makeView(container: AppContainer) -> some View {
        let coordinator = makeCoordinator(
            container: container,
            eventSink: PreviewAppFlowEventSink()
        )
        return OnboardingView(coordinator: coordinator)
    }
    
    static func makeCoordinator(container: AppContainer, eventSink: any AppFlowEventSink) -> OnboardingCoordinator{
        let dataSource: OnboardingDataSource
        
        if container.configuration.environment.userLocalData {
            dataSource = OnboardingLocalDataSourceImpl()
        } else if let baseUrl = container.configuration.environment.apiBasUrl {
            let endpoint = baseUrl.appendingPathComponent("onboarding")
            dataSource = OnboardingRemoteDataSourceImpl(
                networkClient: container.networkClient,
                endpoint: endpoint
            )
        } else {
            dataSource = OnboardingLocalDataSourceImpl()
        }
        
        let onboardingRepository = OnboardingRepositoryImpl(
            onboardingDataSource: dataSource
        )
        let onboardingUseCase = GetOnboardingPageUseCaseImpl(
            onboardingRepository: onboardingRepository
        )
        let viewModel = OnboardingViewModel(onboardingUseCase: onboardingUseCase)
        return OnboardingCoordinator(
            viewModel: viewModel,
            eventSink: eventSink,
        )
    }
}

@MainActor
private final class PreviewAppFlowEventSink: AppFlowEventSink {
    func send(_ event: AppFlowEvent) {}
}
