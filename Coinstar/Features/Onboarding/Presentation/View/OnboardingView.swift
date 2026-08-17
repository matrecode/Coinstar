//
//  OnboardingView.swift
//  Coinstar
//
//  Created by Akshay Matre on 11/08/26.
//

import SwiftUI

struct OnboardingView: View {
    @Bindable private var coordinator: OnboardingCoordinator
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
    }
    var body: some View {
        Group {
            switch coordinator.viewModel.onBoardingState {
            case .idle, .loading:
                ProgressView()
            case .loaded(let pages):
                OnboardingContentView(
                    coordinator: coordinator,
                    pages: pages
                )
            case .failure(let message):
                ContentUnavailableView(
                    "Unable to Load Onboarding",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
            }
        }
        .task {
            await coordinator.viewModel.getOnboardingPages()
        }
    }
    
    private struct OnboardingContentView: View {
        @Bindable var coordinator: OnboardingCoordinator
        let pages: [Onboarding]
        
        var body: some View {
            VStack(spacing: 0) {
                OnboardingSlider(
                    pages: pages,
                    currentPageIndex: Binding(
                        get: { coordinator.viewModel.currentPageIndex },
                        set: { coordinator.viewModel.setPage($0) }
                    )
                )
                
                HStack {
                    OnboardingPageIndicator(
                        totalPages: pages.count,
                        currentPageIndex: coordinator.viewModel.currentPageIndex
                    )
                    .padding(.top, 16)
                    Spacer()
                    OnboardingButton {
                        coordinator.send(.next)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
        }
        
        private func handleNext() {
            if coordinator.viewModel.isLastPage {
                // MARK: - TODO: Navigate to the next screen after onboarding completes
            } else {
                coordinator.viewModel.advance(totalPages: pages.count)
            }
        }
    }
    
    private struct OnboardingSlider: View {
        let pages: [Onboarding]
        @Binding var currentPageIndex: Int
        
        var body: some View {
            TabView(selection: $currentPageIndex) {
                ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                    OnboardingPageView(page: page)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentPageIndex)
        }
        
    }
    
    private struct OnboardingPageIndicator: View {
        let totalPages: Int
        let currentPageIndex: Int
        
        var body: some View {
            HStack(spacing: 8) {
                ForEach(0..<totalPages, id: \.self) { index in
                    let isActive = index == currentPageIndex
                    Capsule()
                       .fill(isActive ? Color.primary : Color.secondary.opacity(0.4))
                       .frame(width: isActive ? 50 : 20,
                              height: isActive ? 10 : 8)
                       .animation(.easeInOut, value: currentPageIndex)
                }
            }
        }
    }
    
    private struct OnboardingButton: View {
        let action: () -> Void

        var body: some View {
            Button(action: action) {
                Image(systemName: "arrow.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Color.black)
                    .clipShape(Circle())
            }
        }
    }
    
    private struct OnboardingPageView: View {
        let page: Onboarding
        var body: some View {
            VStack(spacing: 24) {
                VStack(alignment: .center) {
                    Image(page.image)
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.accentColor)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(page.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                    Text(page.subtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
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

