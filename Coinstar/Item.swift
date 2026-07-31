//
//  Item.swift
//  Coinstar
//
//  Created by Akshay Matre on 31/07/26.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
