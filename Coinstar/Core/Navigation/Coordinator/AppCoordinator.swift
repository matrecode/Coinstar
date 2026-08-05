//
//  AppCoordinator.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/08/26.
//

import Foundation
import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    
    @Published var state = AppState()
    
    func showOnboarding() {
        state.flow = .onboarding
    }
}
