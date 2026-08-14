//
//  OnboardingDTO.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//
import Foundation

struct OnboardingDTO: Decodable {
    let id: UUID
    let title: String
    let subtitle: String
    let image: String
    
    func toDomain() -> Onboarding {
        Onboarding(id: id, title: title, subtitle: subtitle, image: image)
    }
}

struct OnboardingResponseDTO: Decodable {
    let onboardingPages: [OnboardingDTO]
}
