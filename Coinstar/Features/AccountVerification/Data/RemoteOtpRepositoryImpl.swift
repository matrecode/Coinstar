//
//  RemoteOtpRepositoryImpl.swift
//  Coinstar
//
//  Created by Akshay Matre on 07/10/26.
//

import Foundation

final class RemoteOtpRepositoryImpl: OTPRepositoryProtocol{
    private let baseURL: URL
    private let path: String
    private let networkClient: NetworkClient
    
    init(baseURL: URL, path: String = "otp/request", networkClient: NetworkClient){
        self.baseURL = baseURL
        self.path = path
        self.networkClient = networkClient
    }
    
    func requestOtp(for fullNumber: String) async throws -> OTPRequestResult {
        let response: RequestOTPResponse = try await networkClient.post(
            RequestOTPResponse.self,
            to: baseURL.appendingPathComponent(path),
            body: RequestOTPBody(phoneNumber: fullNumber)
        )
        
        return OTPRequestResult(
            success: response.success,
            message: response.message
        )
    }
}

private struct RequestOTPBody: Encodable {
    let phoneNumber: String
}

private struct RequestOTPResponse: Decodable {
    let success: Bool
    let message: String?
}
