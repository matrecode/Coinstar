//
//  OnboardingRepositoryImpl.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//

import Foundation

final class OnboardingRepositoryImpl: OnboardingRepository {


    private let onboardingDataSource: OnboardingDataSource
    
    init(onboardingDataSource: OnboardingDataSource){
        self.onboardingDataSource = onboardingDataSource
    }
    
    func fetchOnboardingPages() async throws -> [Onboarding] {
        let dtos = try await onboardingDataSource.fetchOnboardingPages()
        return dtos.map { $0.toDomain() }
    }
    
}
