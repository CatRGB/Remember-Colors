//
//  Remember_ColorsApp.swift
//  Remember Colors
//
//  Created by Josi Salehi on 27.04.25.
//

import SwiftUI
import SwiftData

@main
struct Remember_ColorsApp: App {
    @StateObject private var gcManager = GameCenterManager.shared
    
    var body: some Scene {
        WindowGroup {
            StartUI()
                .environmentObject(gcManager)
        }
    }
}
