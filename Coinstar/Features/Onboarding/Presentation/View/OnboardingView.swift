//
//  OnboardingView.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var onboardingViewModel: OnboardingViewModel
    init(onboardingViewModel: OnboardingViewModel) {
        _onboardingViewModel = State(wrappedValue: onboardingViewModel)
    }
    var body: some View {
        Group {
            switch onboardingViewModel.onBoardingState {
            case .idle, .loading:
                ProgressView()
            case .loaded(let pages):
                List(pages) { page in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(page.title)
                            .font(.headline)

                        Text(page.subtitle)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, 8)
                }
            case .failure(let message):
                ContentUnavailableView(
                    "Unable to Load Onboarding",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
            }
        }
        .task {
            await onboardingViewModel.getOnboardingPages()
        }
    }
}

#Preview {
    OnboardingBuilder
        .makeView(
            container: AppContainer(
                configuration: AppConfiguration(environment: .local)
            )
        )
}

