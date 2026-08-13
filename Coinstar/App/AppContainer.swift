//
//  AppContainer.swift
//  Coinstar
//
//  Created by Akshay Matre on 13/08/26.
//

import Foundation

@MainActor
final class AppContainer {
    let networkClient: NetworkClient
    let configuration: AppConfiguration
    
    init(configuration: AppConfiguration = .current){
        self.configuration = configuration
        self.networkClient = URLSessionNetworkClient()
    }
}

