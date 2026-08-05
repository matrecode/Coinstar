//
//  BaseCoordinator.swift
//  Coinstar
//
//  Created by Akshay Matre on 05/08/26.
//

import SwiftUI
import Combine

class BaseCoordinator<Route: Hashable>: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
