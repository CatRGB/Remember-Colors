//
//  ShopItems.swift
//  Remember Colors
//
//  Created by Josi Salehi on 06.05.25.
//

import Foundation
import SwiftUI

enum ShopItems: String, CaseIterable, Identifiable {
    case classic = "classic"
    case hexenHut = "hexenHut"
    case skull = "skull"
    
    var id: String { self.rawValue }

    var name: String {
        switch self {
        case .classic: return "Standard"
        case .hexenHut: return "Hexen Hut"
        case .skull: return "Totenschädel"
        }
    }
    
    var image: String? {
        switch self {
        case .classic:
            return nil // kein Bild
        case .hexenHut:
            return "HexenHut-image"
        case .skull:
            return "skull-image"
        }
    }
    
    var coins: Int {
        switch self {
        case .classic: return 0 // immer verfügbar
        case .hexenHut: return 100
        case .skull: return 200
        }
    }
}
