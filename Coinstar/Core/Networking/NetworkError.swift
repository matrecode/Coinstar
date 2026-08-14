//
//  NetworkError.swift
//  Coinstar
//
//  Created by Akshay Matre on 12/08/26.
//
import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidResponse
    case httpStatus(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server returned an invalid response."
        case .httpStatus(let statusCode):
            return "The server returned HTTP status code \(statusCode)."
        }
    }
}
