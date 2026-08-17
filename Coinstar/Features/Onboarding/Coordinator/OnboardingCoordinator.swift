//
//  OnboardingCoordinator.swift
//  Coinstar
//
//  Created by Akshay Matre on 16/08/26.
//
import Foundation
import Observation

@MainActor
@Observable

final class OnboardingCoordinator {
    var path: [OnboardingRoute] = []
    let viewModel: OnboardingViewModel
    
    private weak var eventSink: (any AppFlowEventSink)?
    
    init(
        viewModel: OnboardingViewModel,
        eventSink: (any AppFlowEventSink)? = nil
    ) {
        self.viewModel = viewModel
        self.eventSink = eventSink
    }
    
    func send(_ intent: OnboardingIntent) {
        switch intent {
        case .next:
            handleNext()
        case .back:
            guard !path.isEmpty else { return }
            path.removeLast()
        }
    }

    func navigate(to route: OnboardingRoute) {
        path.append(route)
    }

    private func handleNext() {
        guard case .loaded(let pages) = viewModel.onBoardingState else {
            return
        }

        if viewModel.isLastPage {
            eventSink?.send(.onboardingCompleted)
        } else {
            viewModel.advance(totalPages: pages.count)
        }
    }
}
