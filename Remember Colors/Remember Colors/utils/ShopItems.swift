//
//  ShopItems.swift
//  Remember Colors
//
//  Created by Josi Salehi on 06.05.25.
//

import Foundation
import SwiftUI

enum ShopItems: String, CaseIterable, Identifiable {
    case pixelMon = "pixelmon"
    case dragonyard = "dragonyard"
    
    
    var id: String { self.rawValue }
    
    var name: String {
        switch self {
        case .pixelMon:
            return "pixelmon"
        case .dragonyard:
            return "dragonyard"
        }
    }
    
    var image: String {
        switch self {
        case .pixelMon:
            return "pixelmon-image"
        case .dragonyard:
            return "dragonyard-image"
        }
    }
    
    var coins: Int {
        switch self {
        case .pixelMon:
            return 10
        case .dragonyard:
            return 200
        }
    }
    
    var previewImage: String {
        switch self {
        case .pixelMon:
            return "pixelmon-preview"
        case .dragonyard:
            return "dragonyard-preview"
        }
    }
}
