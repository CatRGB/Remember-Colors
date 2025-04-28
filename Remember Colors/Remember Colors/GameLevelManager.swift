//
//  GameLevelManager.swift
//  Remember Colors
//
//  Created by Josi Salehi on 27.04.25.
//

import Foundation
import SwiftUICore

class GameLevelManager: ObservableObject {
    @Published var colors: [Color] = [.red, .green, .blue, .yellow]
    @Published var availableColors: [Color] = [.purple, .orange, .pink, .cyan, .mint, .indigo, .teal]
    @Published var colorButtonStates: [Bool] = [false, false ,false, false]
    @Published var newlyAddedColorIndex: Int? = nil // Speichert welche Buttons / Farben da zu gekommen sind.
    
    let levelThresholdsForNewColor = [3, 4, 5, 9, 12]
    
    var numberofColors: Int {
        colors.count
    }
    
    func addNewColorIfPossible() {
        if let newColor = availableColors.first {
            colors.append(newColor)
            colorButtonStates.append(false)
            availableColors.removeFirst()
        }
    }
    
    func resetColors() {
        colors = [.red, .green, .blue, .yellow]
        availableColors = [.purple, .orange, .pink, .cyan, .mint, .indigo, .teal]
        colorButtonStates = Array(repeating: false, count: colors.count)
        
    }
    
    func addNewColors() {
        if colors.count < availableColors.count {
            colors.append(availableColors[colors.count])
            colorButtonStates.append(false)
            newlyAddedColorIndex = colors.count - 1 // Neues Farbenfeld merken
        }
    }
    
}
