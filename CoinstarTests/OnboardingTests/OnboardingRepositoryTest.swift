//
//  OnboardingRepositoryTest.swift
//  Coinstar
//
//  Created by Akshay Matre on 15/08/26.
//
import Foundation
import Testing
@testable import Coinstar

@MainActor
struct OnboardingRepositoryTest {
    @Test("Fetch onboarding data and map to dtos to domain models")
    func fetchOnboardingPagesMapsDTOsToDomainModels() async throws {
        let id = UUID()
        let dto = OnboardingDTO(
            id: id,
            title: "Manage your finances.",
            subtitle: "Make finance easy.",
            image: "manage"
        )
        
        let dataSource = MockOnboardingDataSource(result: .success([dto]))
        let repository = OnboardingRepositoryImpl(
            onboardingDataSource: dataSource
        )
        
        let result = try await repository.fetchOnboardingPages()
        
        #expect(result.count == 1)
        #expect(result[0].id == id)
        #expect(result[0].title == "Manage your finances.")
        #expect(result[0].subtitle == "Make finance easy.")
        #expect(result[0].image == "manage")
    }
    
    @Test("Fetch Onbaording Pages Data Source Error")
    func FetchOnbaordingPagesDataSourceError() async {
        let dataSource = MockOnboardingDataSource(
            result: .failure(TestRepositoryError.failed)
        )
        
        let repository = OnboardingRepositoryImpl(
            onboardingDataSource: dataSource
        )
        
        await #expect(throws: TestRepositoryError.failed, performing: {
            try await repository.fetchOnboardingPages()
        })
    }
}


// MARK: - MOCK
private struct MockOnboardingDataSource: OnboardingDataSource {

    let result: Result<[OnboardingDTO], Error>
    
    func fetchOnboardingPages() async throws -> [OnboardingDTO] {
        try result.get()
    }
    
}

// MARK: - ERROR
private enum TestRepositoryError: Error {
    case failed
}
