//
//  OnboardingLocalDataSource.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//
import Foundation

protocol OnboardingLocalDataSource: OnboardingDataSource {
    func fetchOnboardingPages() async throws -> [OnboardingDTO]
}

struct OnboardingLocalDataSourceImpl: OnboardingLocalDataSource {
    private let bundle: Bundle
    private let filename: String
    
    init(bundle: Bundle = .main, filename: String = "onboarding"){
        self.bundle = bundle
        self.filename = filename
    }
    
    func fetchOnboardingPages() async throws -> [OnboardingDTO] {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        let response = try JSONDecoder().decode(OnboardingResponseDTO.self, from: data)
        return response.onboardingPages
    }
}
