//
//  HighscoreManager.swift
//  Remember Colors
//
//  Created by Josi Salehi on 03.05.25.
//

import Foundation

struct Highscore: Identifiable, Codable {
    var id = UUID()
    let date: Date
    let level: Int
}

class HighscoreManager: ObservableObject {
    static let shared = HighscoreManager()
    
    @Published var highscore: [Highscore] = []
    
    private init() {
        loadHighscore()
    }
    
    func addHighscore(level: Int) {
        let newHighscore = Highscore(date: Date(), level: level)
        highscore.append(newHighscore)
        
        // Sortiere absteigend nach Level
        highscore.sort { $0.level > $1.level }
        
        // Maximal 100 Einträge
        if highscore.count > 100 {
            highscore = Array(highscore.prefix(100))
        }
        
        saveHighscores()
    }
    
    private func saveHighscores() {
        if let savedData = try? JSONEncoder().encode(highscore) {
            UserDefaults.standard.set(savedData, forKey: "highscore")
        }
    }
    
    private func loadHighscore() {
        if let savedData = UserDefaults.standard.data(forKey: "highscore") {
            do {
                highscore = try JSONDecoder().decode([Highscore].self, from: savedData)
            } catch {
                print("❌ Fehler beim Laden des Highscores: \(error)")
            }
        }
    }
}
