//
//  ContentView.swift
//  Coinstar
//
//  Created by Akshay Matre on 31/07/26.
//

import SwiftUI

struct RootView: View {
    
    private let appContainer: AppContainer
    
    init(appContainer: AppContainer) {
        self.appContainer = appContainer
    }

    var body: some View {
        OnboardingBuilder.makeView(container: appContainer)
    }
}
