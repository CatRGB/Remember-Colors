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
    
}
