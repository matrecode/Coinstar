//
//  OnbaordingViewModelTests.swift
//  Coinstar
//
//  Created by Akshay Matre on 15/08/26.
//

import Testing
@testable import Coinstar
import Foundation

@MainActor
struct OnboardingViewModelTests {
    // MARK: - Helpers
    func makeSUT(result: Result<[Onboarding], Error> = .success([])) -> OnboardingViewModel {
        let useCase = MockGetOnBoardingUseCase(result: result)
        return OnboardingViewModel(onboardingUseCase: useCase)
    }
    
    private func makePages() -> [Onboarding] {
        return [
            Onboarding(
                id: UUID(),
                title: "Manage your finances.",
                subtitle: "Make finance easy.",
                image: "manage"
            ),
            Onboarding(
                id: UUID(),
                title: "Control your savings.",
                subtitle: "Save money easily.",
                image: "control"
            ),
            Onboarding(
                id: UUID(),
                title: "Easy banking.",
                subtitle: "Banking made simple.",
                image: "banking"
            )
        ]
    }
    
    
    @Test("initial test")
    func initialStateIsIdle() {
        let sut = makeSUT()
        
        #expect(sut.onBoardingState == .idle)
        #expect(sut.currentPageIndex == 0)
    }
    
    @Test("load pages succesfully")
    func getOnboardingPagesLoadsPagesSuccessfully() async {
        let pages = makePages()
        
        let sut = makeSUT(result: .success(pages))
        await sut.getOnboardingPages()
        #expect(sut.onBoardingState == .loaded(pages))
        
    }
    
    @Test("loading pages failed")
    func getOnboardingPagesFailsWhenuseCaseFails() async {
        let sut = makeSUT(result: .failure(TestError.network))
        
        await sut.getOnboardingPages()
        
        #expect(
            sut.onBoardingState ==
                .failure(TestError.network.localizedDescription)
        )
    }
    
    @Test
    func getOnboardingPagesDoesNotLoadTwice() async {
        let pages = makePages()
        let useCase = MockGetOnBoardingUseCase(
            result: .success(pages)
        )

        let sut = OnboardingViewModel(
            onboardingUseCase: useCase
        )

        await sut.getOnboardingPages()
        await sut.getOnboardingPages()

        #expect(useCase.callCount == 1)
    }

    @Test
    func setPageChangesCurrentPageIndex() {
        let sut = makeSUT()

        sut.setPage(2)

        #expect(sut.currentPageIndex == 2)
    }

    @Test
    func advanceMovesToNextPage() {
        let sut = makeSUT()

        let result = sut.advance(totalPages: 3)

        #expect(result == true)
        #expect(sut.currentPageIndex == 1)
    }

    @Test
    func advanceCanMoveFromSecondToThirdPage() {
        let sut = makeSUT()

        sut.setPage(1)

        let result = sut.advance(totalPages: 3)

        #expect(result == true)
        #expect(sut.currentPageIndex == 2)
    }

    @Test
    func advanceDoesNotMovePastLastPage() {
        let sut = makeSUT()

        sut.setPage(2)

        let result = sut.advance(totalPages: 3)

        #expect(result == false)
        #expect(sut.currentPageIndex == 2)
    }

    @Test
    func isLastPageIsFalseOnFirstPage() async {
        let pages = makePages()
        let sut = makeSUT(
            result: .success(pages)
        )

        await sut.getOnboardingPages()

        #expect(sut.isLastPage == false)
    }

    @Test
    func isLastPageIsTrueOnLastPage() async {
        let pages = makePages()
        let sut = makeSUT(
            result: .success(pages)
        )

        await sut.getOnboardingPages()
        sut.setPage(pages.count - 1)

        #expect(sut.isLastPage == true)
    }
    
    
}

// MARK: - Mock

private final class MockGetOnBoardingUseCase: GetOnboardinPageUseCase {
    private let result: Result<[Onboarding], Error>
    private(set) var callCount = 0
    
    init(result: Result<[Onboarding], Error>, callCount: Int = 0) {
        self.result = result
        self.callCount = callCount
    }
    
    func getOnboardingPages() async throws -> [Onboarding] {
        callCount += 1
        return try result.get()
    }
}

// MARK: - Test Error

private enum TestError: Error, LocalizedError {
    case network

    var errorDescription: String? {
        switch self {
        case .network:
            return "Network error"
        }
    }
}
