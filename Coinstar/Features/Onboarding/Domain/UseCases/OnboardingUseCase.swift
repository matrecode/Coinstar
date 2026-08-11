//
//  OnboardingUseCase.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import Combine

protocol OnboardingUseCase {
    func getOnboardingPages() -> AnyPublisher<[Onboarding], Error>
}

class OnboardingUseCaseImpl: OnboardingUseCase {
    let onboardingRepository: OnboardingRepository
    
    init(onboardingRepository: OnboardingRepository){
        self.onboardingRepository = onboardingRepository
    }
    func getOnboardingPages() -> AnyPublisher<[Onboarding], any Error> {
        return onboardingRepository.fetchOnboardingPages()
    }
}
