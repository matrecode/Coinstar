//
//  OnboardingRemoteDataSource.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//
import Foundation

protocol OnboardingRemoteDataSource: OnboardingDataSource {
    func fetchOnboardingPages() async throws -> [OnboardingDTO]
}

struct OnboardingRemoteDataSourceImpl: OnboardingRemoteDataSource {
    private let networkCLient: NetworkClient
    private let endpoint: URL
    
    init(networkClient: NetworkClient, endpoint: URL){
        self.networkCLient = networkClient
        self.endpoint = endpoint
    }
    
    func fetchOnboardingPages() async throws -> [OnboardingDTO] {
        let response = try await networkCLient.request(
            OnboardingResponseDTO.self,
            from: endpoint
        )
        return response.onboardingPages
    }
}
