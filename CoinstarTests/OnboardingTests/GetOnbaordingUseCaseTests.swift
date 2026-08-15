//
//  GetOnbaordingUseCaseTests.swift
//  Coinstar
//
//  Created by Akshay Matre on 15/08/26.
//
import Foundation
import Testing
@testable import Coinstar

@MainActor
struct GetOnbaordingUseCaseTests {
    @Test
    func getOnboardingPagesFromRepository() async throws{
        let pages = [
            Onboarding(
                id: UUID(),
                title: "Manage your finances.",
                subtitle: "Make finance easy.",
                image: "manage"
            )
        ]
        
        let repository = MockOnboardingRepository(result: .success(pages))
        let useCase = GetOnboardingPageUseCaseImpl(
            onboardingRepository: repository
        )
        
        let result = try await useCase.getOnboardingPages()
        #expect(result == pages)
    }
    
    @Test
    func getOnboardingPagesFromRepositoryError() async {
        let repository = MockOnboardingRepository(
            result: .failure(OnboardingRepositoryError.failed)
        )
        let useCase = GetOnboardingPageUseCaseImpl(
            onboardingRepository: repository
        )
        
        await #expect(throws: OnboardingRepositoryError.failed, performing: {
            try await useCase.getOnboardingPages()
        })
    }
}

private struct MockOnboardingRepository: OnboardingRepository {
    let result: Result<[Onboarding], Error>
    
    func fetchOnboardingPages() async throws -> [Onboarding] {
        try result.get()
    }
}

private enum OnboardingRepositoryError: Error {
    case failed
}
