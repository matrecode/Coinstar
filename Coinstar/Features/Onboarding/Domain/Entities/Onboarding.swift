//
//  Onboarding.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation

struct Onboarding: Codable, Sendable, Identifiable, Equatable {
    var id: UUID
    let title: String
    let subtitle: String
    let image: String
}
