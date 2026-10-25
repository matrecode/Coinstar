//
//  AccountVerificationRoute.swift
//  Coinstar
//
//  Created by Akshay Matre on 22/10/26.
//

import Foundation

enum AccountVerificationRoute: Hashable {
    case otpVerification(fullNumber: String)
}
