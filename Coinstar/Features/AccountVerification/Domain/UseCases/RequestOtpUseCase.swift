//
//  RequestOtpUseCase.swift
//  Coinstar
//
//  Created by Akshay Matre on 07/10/26.
//

import Foundation

protocol RequestOTPUseCaseProtocol {
    func execute(fullNumber: String) async throws -> OTPRequestResult
}

final class RequestOtpUseCase: RequestOTPUseCaseProtocol {
    private let repository: OTPRepositoryProtocol
    
    init(repository: OTPRepositoryProtocol){
        self.repository = repository
    }
    
    func execute(fullNumber: String) async throws -> OTPRequestResult {
        try await repository.requestOtp(for: fullNumber)
    }
}
