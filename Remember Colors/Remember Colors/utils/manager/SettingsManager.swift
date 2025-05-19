//
//  SettingsManager.swift
//  Remember Colors
//
//  Created by Josi Salehi on 19.05.25.
//

import Foundation
import Combine

class SettingsManager: ObservableObject {
    @Published var vibrationEnabled: Bool {
        didSet {
            UserDefaults.standard.set(vibrationEnabled, forKey: "vibrationEnabled")
        }
    }
    
    static let shared = SettingsManager()
    
    private init() {
        self.vibrationEnabled = UserDefaults.standard.bool(forKey: "vibrationEnabled")
    }
    
}
