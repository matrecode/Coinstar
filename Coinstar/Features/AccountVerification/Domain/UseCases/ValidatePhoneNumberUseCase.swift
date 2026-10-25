//
//  ValidatePhoneNumberUseCase.swift
//  Coinstar
//
//  Created by Akshay Matre on 07/10/26.
//

import Foundation


struct PhoneValidationResult {
    let isValid: Bool
    let fullNumber: String
    let expectedLengthRange: ClosedRange<Int>
}

protocol ValidatePhoneNumberUseCaseProtocol {
    func executeValidation(rawInput: String, country: Country) -> PhoneValidationResult
}

final class ValidatePhoneNumberUseCase: ValidatePhoneNumberUseCaseProtocol {
    func executeValidation(rawInput: String, country: Country) -> PhoneValidationResult {
        let digitsOnly = rawInput.filter(\.isNumber)
        let expectedLengthRange = country.phoneNumberLengthRange
        let isValid = expectedLengthRange.contains(digitsOnly.count)
        let fullNumber = country.dialCode + digitsOnly

        return PhoneValidationResult(
            isValid: isValid,
            fullNumber: fullNumber,
            expectedLengthRange: expectedLengthRange
        )
    }
}
