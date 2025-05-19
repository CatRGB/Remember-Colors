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
    @StateObject private var currencyManager = CurrencyManager()
    @StateObject private var shopState = ShopState()
    @StateObject private var settingsManager = SettingsManager.shared

    
    var body: some Scene {
        WindowGroup {
            StartUI()
                .environmentObject(gcManager)
                .environmentObject(currencyManager)
                .environmentObject(shopState)
                .environmentObject(settingsManager)
        }
    }
}
