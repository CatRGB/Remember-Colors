//
//  GameCenterManager.swift
//  Remember Colors
//
//  Created by Josi Salehi on 03.05.25.
//

import Foundation
import GameKit
import UIKit

private extension UIApplication {
    /// Hilfs-Extension, um den aktuellen Key-Window RootViewController in SwiftUI-Apps zu finden
    static var rootViewController: UIViewController? {
        shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}

/// Singleton, das Game Center Auth, Score-Submit und Laden von Scores kapselt
class GameCenterManager: NSObject, ObservableObject, GKGameCenterControllerDelegate {
    
    static let shared = GameCenterManager()
    
    /// Authentifizierungs-Status
    @Published var isAuthenticated = false
    
    /// Geladene Top-Scores
    @Published var topScores: [GKScore] = []
    
    private override init() {
        super.init()
        authenticatePlayer()
    }
    
    /// Aufruf nur wenn der Nutzer Login will
    func authenticatePlayer(force: Bool = false) {
        let local = GKLocalPlayer.local

        // Falls der Spieler bereits authentifiziert ist, abbrechen – außer es ist "force"
        guard force || !local.isAuthenticated else {
            self.isAuthenticated = true
            return
        }

        local.authenticateHandler = { [weak self] vc, error in
            if let loginVC = vc {
                DispatchQueue.main.async {
                    UIApplication.rootViewController?.present(loginVC, animated: true)
                }
            } else if local.isAuthenticated {
                DispatchQueue.main.async {
                    self?.isAuthenticated = true
                }
            } else {
                DispatchQueue.main.async {
                    self?.isAuthenticated = false
                }
                if let error = error {
                    print("❌ Game Center Auth error:", error.localizedDescription)
                }
            }
        }
    }
    
    /// Sendet den besten Level an dein GC-Leaderboard
    func submitScore(_ level: Int) {
        guard isAuthenticated else { return }
        
        if #available(iOS 14.0, *) {
            GKLeaderboard.submitScore(
                level,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: ["Remember_Highscore_Online"]
            ) { error in
                if let err = error {
                    print("❌ Submit (iOS14+):", err.localizedDescription)
                }
            }
        } else {
            let score = GKScore(leaderboardIdentifier: "Remember_Highscore_Online")
            score.value = Int64(level)
            GKScore.report([score]) { error in
                if let err = error {
                    print("❌ Submit (Legacy):", err.localizedDescription)
                }
            }
        }
    }
    
    /// Lädt die Top-Scores aus dem Game-Center-Leaderboard
    func fetchTopScores(limit: Int = 10) {
        let leaderboardID = "Remember_Highscore_Online"

        if #available(iOS 14.0, *) {
            // iOS 14+: Lade zuerst das Leaderboard-Objekt
            GKLeaderboard.loadLeaderboards(IDs: [leaderboardID]) { leaderboards, error in
                guard let board = leaderboards?.first, error == nil else {
                    print("❌ Leaderboard-Load failed:", error?.localizedDescription ?? "Unknown")
                    return
                }
                // Gib an, dass wir die globale Bestenliste über alle Zeiten wollen
                board.playerScope = GKLeaderboard.PlayerScope.global
                board.timeScope   = GKLeaderboard.TimeScope.allTime
                // Bereich ist ein NSRange, nicht 1...limit
                board.range       = NSRange(location: 1, length: limit)

                // Lade die Scores
                board.loadScores { scores, error in
                    DispatchQueue.main.async {
                        self.topScores = scores ?? []
                    }
                }
            }
        } else {
            // Fallback für iOS < 14: Verwende den Default-Initializer statt init(players:)
            let board = GKLeaderboard()
            board.identifier  = leaderboardID
            board.playerScope = GKLeaderboard.PlayerScope.global
            board.timeScope   = GKLeaderboard.TimeScope.allTime
            board.range       = NSRange(location: 1, length: limit)

            board.loadScores { scores, error in
                DispatchQueue.main.async {
                    self.topScores = scores ?? []
                }
            }
        }
    }

    
    /// Delegate-Methode: schließt den GC-Controller
    func gameCenterViewControllerDidFinish(_ controller: GKGameCenterViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Zeigt das native GC-Leaderboard-UI
    func showLeaderboard() {
        guard isAuthenticated else { return }
        let vc: GKGameCenterViewController
        if #available(iOS 14.0, *) {
            vc = GKGameCenterViewController(
                leaderboardID: "Remember_Highscore_Online",
                playerScope: .global,
                timeScope: .allTime
            )
        } else {
            vc = GKGameCenterViewController(state: .leaderboards)
            vc.leaderboardIdentifier = "Remember_Highscore_Online"
        }
        vc.gameCenterDelegate = self
        DispatchQueue.main.async {
            UIApplication.rootViewController?
                .present(vc, animated: true)
        }
    }
    
    func reportAchievement(identifier: String, percentComplete: Double) {
        guard isAuthenticated else { return }
        
        let achievement = GKAchievement(identifier: identifier)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = true
        
        GKAchievement.report([achievement]) { error in
            if let error = error {
                print("❌ Achievement Error: \(error.localizedDescription)")
            } else {
                print("✅ Achievement '\(identifier)' gemeldet")
            }
        }
    }
    
    func showAchievements() {
        guard isAuthenticated else { return }
        
        let vc = GKGameCenterViewController()
        vc.viewState = .achievements
        vc.gameCenterDelegate = self
        
        DispatchQueue.main.async {
            UIApplication.rootViewController?.present(vc, animated: true)
        }
    }
    
    
    func reportAchievementOnce(identifier: String, percentComplete: Double = 100) {
        GKAchievement.loadAchievements { achievements, error in
            guard let achievements = achievements else { return }
            if achievements.first(where: { $0.identifier == identifier })?.isCompleted == false {
                self.reportAchievement(identifier: identifier, percentComplete: percentComplete)
            }
        }
    }
    
}
