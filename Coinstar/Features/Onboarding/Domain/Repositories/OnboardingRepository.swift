//
//  OnboardingRepository.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//

protocol OnboardingRepository {
    func fetchOnboardingPages() async throws -> [Onboarding]
}
