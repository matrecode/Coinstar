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
    
    static func makeView() -> some View {

        let onBoardingService = OnboardingService(
            networkService: NetworkService()
        )
        let onboardingRepository = OnboardingRepositoryImpl(
            onboardignService: onBoardingService
        )
        let onBoardingUseCase = OnboardingUseCaseImpl(
            onboardingRepository: onboardingRepository
        )
        let onboardingViewModel = OnboardingViewModel(
            onboardingUseCase: onBoardingUseCase
        )
        
        return OnboardingView(onboardingViewModel: onboardingViewModel)
    }
}
