//
//  AccountVerificationViewModel.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/10/26.
//

import Foundation
import Combine

final class AccountVerificationViewModel: ObservableObject {
    @Published var selectedCountry: Country
    @Published var errorMessage: String? = nil
    @Published var isDropdownExpanded: Bool = false
    @Published private(set) var phoneNumber: String = ""
    @Published private(set) var isRequestingOTP: Bool = false
    @Published private(set) var otpRequestToken: UUID? = nil
    @Published private(set) var requestedFullNumber: String? = nil

    let countries: [Country]

   // MARK: Dependencies (Domain-layer protocols only)
    private let validatePhoneNumberUseCase: ValidatePhoneNumberUseCaseProtocol
    private let requestOTPUseCase: RequestOTPUseCaseProtocol
    
    init(getCountriesUseCase: GetCountriesUseCaseProtocol, validatePhoneNumberUseCase: ValidatePhoneNumberUseCaseProtocol, requestOTPUseCase: RequestOTPUseCaseProtocol, defaultCountry: Country = .default){
        self.validatePhoneNumberUseCase = validatePhoneNumberUseCase
        self.requestOTPUseCase = requestOTPUseCase
        self.countries = Country.all
        self.selectedCountry = defaultCountry
    }
    
    var isNextEnabled: Bool {
        validatePhoneNumberUseCase.executeValidation(
                rawInput: phoneNumber,
                country: selectedCountry
            ).isValid
    }
    
    func didSelectCountry(_ country: Country) {
        selectedCountry = country
        isDropdownExpanded = false
        applyPhoneNumber(phoneNumber)
    }

    func didTapCountryField() {
        isDropdownExpanded.toggle()
    }

    func didTapOutsideDropdown() {
        isDropdownExpanded = false
    }

    func updatePhoneNumber(_ rawValue: String) {
        applyPhoneNumber(rawValue)
    }

    private func applyPhoneNumber(_ rawValue: String) {
        let maxLength = selectedCountry.phoneNumberLengthRange.upperBound
        let digitsOnly = rawValue.filter(\.isNumber)

        guard digitsOnly.count <= maxLength else {
            phoneNumber = String(digitsOnly.prefix(maxLength))
            errorMessage = "Mobile number for \(selectedCountry.name) can have at most \(maxLength) digits"
            return
        }

        phoneNumber = digitsOnly
        errorMessage = nil
    }

    func didTapNext(){
        let validation = validatePhoneNumberUseCase.executeValidation(
            rawInput: phoneNumber,
            country: selectedCountry
        )
        
        guard validation.isValid else {
            errorMessage = lengthValidationMessage(for: validation.expectedLengthRange)
            return
        }

        Task { await requestOtp(fullNumber: validation.fullNumber)}
    }

    private func lengthValidationMessage(for range: ClosedRange<Int>) -> String {
        if range.lowerBound == range.upperBound {
            return "Enter a \(range.lowerBound)-digit mobile number for \(selectedCountry.name)"
        } else {
            return "Enter a \(range.lowerBound)-\(range.upperBound) digit mobile number for \(selectedCountry.name)"
        }
    }


    private func requestOtp(fullNumber: String) async {
        isRequestingOTP = true
        errorMessage = nil

        defer { isRequestingOTP = false }

        do {
            _ = try await requestOTPUseCase.execute(fullNumber: fullNumber)
            requestedFullNumber = fullNumber
            otpRequestToken = UUID()
        } catch {
            errorMessage = (error as? LocalizedError)?.errorDescription ?? "Something went wrong. Please try again."
        }
    }
}
