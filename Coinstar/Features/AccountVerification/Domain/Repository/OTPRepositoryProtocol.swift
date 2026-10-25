//
//  OTPRepositoryProtocol.swift
//  Coinstar
//
//  Created by Akshay Matre on 07/10/26.
//

import Foundation

struct OTPRequestResult {
    let success: Bool
    let message: String?
}

enum OTPError: Error, LocalizedError {
    case invalidPhoneNumber
    
    var errorDescription: String? {
        switch self {
            case .invalidPhoneNumber:
                return "Please enter a valid mobile number"
        }
    }
}

protocol OTPRepositoryProtocol {
    func requestOtp(for fullNumber: String) async throws -> OTPRequestResult
}
