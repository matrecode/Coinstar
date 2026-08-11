//
//  Onboarding.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation

struct Onboarding: Codable, Sendable, Identifiable {
    var id: UUID
    let title: String
    let subtitle: String
}

struct OnboardingResponse: Codable, Sendable {
    let onboardingPages: [Onboarding]
}
