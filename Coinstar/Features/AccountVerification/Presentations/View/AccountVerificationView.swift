//
//  AccountVerificationView.swift
//  Coinstar
//
//  Created by Akshay Matre on 18/08/26.
//

import Foundation
import SwiftUI

struct AccountVerificationView: View {
    
    @StateObject private var viewModel: AccountVerificationViewModel
    private let coordinator: AccountVerificationCoordinator
    @FocusState private var isPhoneFieldFocused: Bool

    init(coordinator: AccountVerificationCoordinator){
        self.coordinator = coordinator
        _viewModel = StateObject(wrappedValue: coordinator.viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                header
                    .padding(.top, 24)
                    .padding(.horizontal, 24)

                Spacer().frame(height: 56)

                phoneRow
                    .padding(.horizontal, 24)

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 13))
                        .foregroundColor(.red)
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                }

                Spacer()

                footer
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }

            if viewModel.isDropdownExpanded {
                Color.black.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.18)) {
                            viewModel.didTapOutsideDropdown()
                        }
                    }
            }
        }
        .countryPickerDropdownHost()
        .onChange(of: viewModel.otpRequestToken) { _, newToken in
            guard newToken != nil else { return }
            coordinator.handleOtpRequested()
        }
    }
    
    // MARK: Header
    private var header: some View {
        VStack(spacing: 12){
            Text("Get Started")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
            
            Text("Please enter your mobile number\nto verify your account")
                .font(.system(size: 16))
                .foregroundColor(.black.opacity(0.55))
                .multilineTextAlignment(.center)
        }
    }
    
    // MARK: PhoneRow
    private var phoneRow: some View {
        VStack(spacing: 6){
            HStack(alignment: .top, spacing: 12) {
                CountryPickerView(
                    selectedCountry: $viewModel.selectedCountry,
                    isExpanded: $viewModel.isDropdownExpanded,
                    countries: viewModel.countries,
                    onSelect: { viewModel.didSelectCountry($0) }
                )
                
                TextField("000-000-0000", text: phoneNumberBinding)
                    .keyboardType(.numberPad)
                    .font(.system(size: 26, weight: .medium))
                    .focused($isPhoneFieldFocused)
                    .frame(height: 56)
            }
            
            Rectangle()
                .fill(isPhoneFieldFocused ? Color.black.opacity(0.85) : Color.black.opacity(0.12))
                .frame(height: 1)
        }
    }

    private var phoneNumberBinding: Binding<String> {
        Binding(
            get: { viewModel.phoneNumber },
            set: { viewModel.updatePhoneNumber($0) }
        )
    }


    // MARK: footer
    private var footer: some View {
        VStack(spacing: 20) {
            Text("By clicking \"Next\" you agree to the privacy policy and terms of service")
                .foregroundColor(.black.opacity(0.55))
                .font(.system(size: 14))
                .multilineTextAlignment(.center)

            Button {
                viewModel.didTapNext()
            } label: {
                HStack(spacing: 8) {
                    if viewModel.isRequestingOTP {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Next")
                            .font(.system(size: 17, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(viewModel.isNextEnabled ? Color.black : Color.black.opacity(0.25))
                .clipShape(Capsule())
            }
            .disabled(!viewModel.isNextEnabled || viewModel.isRequestingOTP)
        }
    }

}

#Preview {
    AccountVerificationBuilder.makeView(
        container: AppContainer(
            configuration: AppConfiguration(environment: .local)
        )
    )
}
