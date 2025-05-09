//
//  CurrencyManager.swift
//  Remember Colors
//
//  Created by Josi Salehi on 09.05.25.
//

import Foundation

class CurrencyManager: ObservableObject {
    
    @Published var coins: Int {
        didSet {
            UserDefaults.standard.set(coins, forKey: "coins")
        }
    }
    
    init() {
        self.coins = UserDefaults.standard.integer(forKey: "coins")
    }
    
    func addCoins(_ amount: Int) {
        self.coins += amount
    }
    
    func spendCoins(_ amount: Int) -> Bool {
        if coins >= amount {
            coins -= amount
            return true
        } else {
            return false
        }
    }
}
