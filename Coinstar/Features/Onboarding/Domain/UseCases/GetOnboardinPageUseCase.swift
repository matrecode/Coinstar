//
//  OnboardingUseCase.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import Combine

protocol GetOnboardinPageUseCase {
    func getOnboardingPages() async throws -> [Onboarding]
}

class GetOnboardingPageUseCaseImpl: GetOnboardinPageUseCase {

    private let onboardingRepository: OnboardingRepository
    
    init(onboardingRepository: OnboardingRepository){
        self.onboardingRepository = onboardingRepository
    }
    
    func getOnboardingPages() async throws -> [Onboarding] {
        try await onboardingRepository.fetchOnboardingPages()
    }

}
