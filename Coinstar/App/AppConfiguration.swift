//
//  AppConfiguration.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//

import Foundation

struct AppConfiguration {
    let environment: AppEnvironment
    
    static let current = AppConfiguration(environment: .local)
}

enum AppEnvironment {
    case local
    case development
    case staging
    case production
    
    var apiBasUrl: URL? {
        switch self {
            case .local:
                return nil
            case .development:
                return URL(string: "http://127.0.0.1:3001")
            case .staging:
                return URL(string: "https://staging-api.example.com")
            case .production:
                return URL(string: "https://api.example.com")
        }
    }
    
    var userLocalData: Bool {
        self == .local
    }
}
