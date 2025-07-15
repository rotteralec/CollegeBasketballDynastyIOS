//
//  Item.swift
//  CollegeBasketballDynastyIOS
//
//  Created by Al Rotter on 7/14/25.
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
