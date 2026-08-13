//
//  OnboardingDataSource.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//

import Foundation

protocol OnboardingDataSource {
    func fetchOnboardingPages() async throws -> [OnboardingDTO]
}
