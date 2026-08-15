//
//  OnboardingDataSourceTests.swift
//  Coinstar
//
//  Created by Akshay Matre on 15/08/26.
//

import Foundation
import Testing
@testable import Coinstar

@MainActor
struct OnboardingDataSourceTests {
    
    @Test
    func fetchOnbaordingPagesFromRemoteDataSourceResponse() async throws {
        let id = UUID()
        let response = OnboardingResponseDTO(
            onboardingPages: [
                OnboardingDTO(
                    id: id,
                    title: "Manage your finances.",
                    subtitle: "Make finance easy.",
                    image: "manage"
                )
            ]
        )
        
        let networkClient = MockNetworkClient(result: .success(response))
        let endpoint = URL(string: "https://example.com/onboarding")!
        
        let dataSource = OnboardingRemoteDataSourceImpl(
            networkClient: networkClient,
            endpoint: endpoint
        )
        
        let result = try await dataSource.fetchOnboardingPages()
        
        #expect(result.count == 1)
        #expect(result[0].id == id)
        #expect(result[0].title == "Manage your finances.")
        #expect(networkClient.requestURL == endpoint)
    }
    
    @Test
    func fetchOnboardingPagesNetworkError() async {
        let networkClient = MockNetworkClient(
            result: .failure(TestNetworkError.failed)
        )

        let endpoint = URL(string: "https://example.com/onboarding")!

        let dataSource = OnboardingRemoteDataSourceImpl(
            networkClient: networkClient,
            endpoint: endpoint
        )

        await #expect(throws: TestNetworkError.failed) {
            try await dataSource.fetchOnboardingPages()
        }
    }
}

private final class MockNetworkClient: NetworkClient {
    let result: Result<OnboardingResponseDTO, Error>
    
    private(set) var requestURL: URL?
    
    init(result: Result<OnboardingResponseDTO, Error>) {
        self.result = result
    }
    
    func request<T>(_ type: T.Type, from url: URL) async throws -> T where T : Decodable {
        requestURL = url
        let response = try result.get()
        
        guard let data = response as? T else {
            throw TestNetworkError.invalidType
        }
        
        return data
    }
}

// MARK: - Error

private enum TestNetworkError: Error {
    case failed
    case invalidType
}
