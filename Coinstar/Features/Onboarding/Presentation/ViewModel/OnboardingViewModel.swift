//
//  OnboardingViewModel.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    private let onboardingUseCase: OnboardingUseCase
    @Published var onbaordingPages: [Onboarding] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(onboardingUseCase: OnboardingUseCase){
        self.onboardingUseCase = onboardingUseCase
    }
    
    func getOnboardingPages() {
        onboardingUseCase.getOnboardingPages()
            .sink(receiveCompletion: { completion in
                // handle errors
            }, receiveValue: { pages in
                self.onbaordingPages = pages
            })
            .store(in: &cancellables)
        print(onbaordingPages)
    }
}
