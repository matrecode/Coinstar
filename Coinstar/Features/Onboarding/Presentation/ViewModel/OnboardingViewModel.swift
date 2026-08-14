//
//  OnboardingViewModel.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import Foundation
import Combine

enum OnboardingState: Equatable {
    case idle
    case loading
    case loaded([Onboarding])
    case failure(String)
}

@MainActor
@Observable
class OnboardingViewModel: ObservableObject {
    private let onboardingUseCase: GetOnboardinPageUseCase
    private(set) var onBoardingState: OnboardingState = .idle
    private(set) var currentPageIndex: Int = 0
    
    var isLastPage: Bool {
        guard case .loaded(let pages) = onBoardingState else { return false }
        return currentPageIndex == pages.count - 1
    }
    
    init(onboardingUseCase: GetOnboardinPageUseCase){
        self.onboardingUseCase = onboardingUseCase
    }
    
    func getOnboardingPages() async {
        
        guard onBoardingState == .idle else {
            return
        }
        
        onBoardingState = .loading
        
        do {
            let onbaordingPages = try await onboardingUseCase.getOnboardingPages()
            onBoardingState = .loaded(onbaordingPages)
        } catch {
            onBoardingState = .failure(error.localizedDescription)
        }
        
    }
    
    func setPage(_ index: Int) {
        currentPageIndex = index
    }
    
    @discardableResult
    func advance(totalPages: Int) -> Bool {
        guard currentPageIndex < totalPages - 1 else { return false }
        currentPageIndex += 1
        return true
    }
}
