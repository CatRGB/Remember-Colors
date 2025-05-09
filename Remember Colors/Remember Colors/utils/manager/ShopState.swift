//
//  ShopState.swift
//  Remember Colors
//
//  Created by Josi Salehi on 09.05.25.
//

import Foundation

class ShopState: ObservableObject {
    @Published var unLockedItem: Set<String> {
        didSet {
            UserDefaults.standard.set(Array(unLockedItem), forKey: "unLockedItem")
        }
    }
    
    @Published var selectedSkinID: String {
        didSet {
            UserDefaults.standard.set(selectedSkinID, forKey: "selectedSkinID")
        }
    }
    
    init() {
        let saved = UserDefaults.standard.stringArray(forKey: "unLockedItem") ?? []
        self.unLockedItem = Set(saved)
        self.selectedSkinID = UserDefaults.standard.string(forKey: "selectedSkinID") ?? "default"
    }
    
    
    func isUnlocked(_ item: ShopItems) -> Bool {
        unLockedItem.contains(item.id)
    }
    
    func unlock(_ item: ShopItems) {
        unLockedItem.insert(item.id)
    }
}
