//
//  AppState.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/08/26.
//

import SwiftUI
import Combine

final class AppState: ObservableObject {

    @Published
    var flow: AppFlow

    init() {

        let isFirstLaunch = false

        if isFirstLaunch {
            self.flow = .onboarding
        } else {
            self.flow = .registration
        }
    }
}
