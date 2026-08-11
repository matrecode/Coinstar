//
//  OnboardingRepository.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import Combine

protocol OnboardingRepository {
    func fetchOnboardingPages() -> AnyPublisher<[Onboarding], Error>
}

final class OnboardingRepositoryImpl: OnboardingRepository {
    let onboardingService: OnboardingService
    
    init(onboardignService: OnboardingService){
        self.onboardingService = onboardignService
    }
    func fetchOnboardingPages() -> AnyPublisher<[Onboarding], Error> {
        return onboardingService.fetchOnboardingPages(fromLocalJson: true)
    }
}
