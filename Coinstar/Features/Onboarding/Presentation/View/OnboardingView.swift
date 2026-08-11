//
//  OnboardingView.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var onboardingViewModel: OnboardingViewModel
    init(onboardingViewModel: OnboardingViewModel) {
        _onboardingViewModel = StateObject(wrappedValue: onboardingViewModel)
    }
    var body: some View {
        List(onboardingViewModel.onbaordingPages) { page in
           VStack(alignment: .leading, spacing: 8) {
               Text(page.title)
                   .font(.headline)

               Text(page.subtitle)
                   .font(.subheadline)
                   .foregroundStyle(.secondary)
           }
           .padding(.vertical, 8)
       }
        .task {
            onboardingViewModel.getOnboardingPages()
        }
    }
}

#Preview {
    OnboardingView(
        onboardingViewModel: OnboardingViewModel(
            onboardingUseCase: OnboardingUseCaseImpl(
                onboardingRepository: OnboardingRepositoryImpl(
                    onboardignService: OnboardingService(
                        networkService: NetworkService()
                    )
                )
            )
        )
    )
}

