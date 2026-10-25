//
//  LocalOtpRepositoryImpl.swift
//  Coinstar
//
//  Created by Akshay Matre on 22/10/26.
//

import Foundation

/// Mock OTP repository used in the `.local` environment, where no API
/// base URL is configured.
final class LocalOtpRepositoryImpl: OTPRepositoryProtocol {
    func requestOtp(for fullNumber: String) async throws -> OTPRequestResult {
        OTPRequestResult(success: true, message: "OTP sent to \(fullNumber) (local/mock)")
    }
}
