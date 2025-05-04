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
    /// Liefert den aktuellen Key-Window-RootViewController in SwiftUI-Apps
    static var rootViewController: UIViewController? {
        shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}

class GameCenterManager: NSObject, ObservableObject, GKGameCenterControllerDelegate {
    
    static let shared = GameCenterManager()
    @Published var isAuthenticated = false
    
    private override init() {
        super.init()
        authenticatePlayer()
    }
    
    /// Authentifiziert den lokalen Spieler bei Game Center
    func authenticatePlayer() {
        let local = GKLocalPlayer.local
        local.authenticateHandler = { [weak self] vc, error in
            if let loginVC = vc {
                // Login-Screen anzeigen
                DispatchQueue.main.async {
                    UIApplication.rootViewController?
                        .present(loginVC, animated: true)
                }
            } else if local.isAuthenticated {
                // erfolgreich angemeldet
                self?.isAuthenticated = true
                print("✅ GC: Spieler authentifiziert")
            } else {
                // nicht angemeldet oder Fehler
                self?.isAuthenticated = false
                print("❌ GC Auth-Fehler:", error?.localizedDescription ?? "Unbekannt")
            }
        }
    }
    
    /// Meldet den besten Level an Game Center
    func submitScore(_ level: Int) {
        guard isAuthenticated else {
            print("⚠️ GC nicht authentifiziert – Score nicht gesendet")
            return
        }
        
        if #available(iOS 14.0, *) {
            // Neuer iOS-14+ API-Aufruf: direkt mehrere Leaderboards supporten
            GKLeaderboard.submitScore(
                level,                // dein Integer-Score
                context: 0,           // frei wählbares Meta-Feld (hier 0)
                player: GKLocalPlayer.local,
                leaderboardIDs: ["Remember_Highscore_Online"]
            ) { error in
                if let err = error {
                    print("❌ Fehler beim Submit (iOS14+):", err.localizedDescription)
                } else {
                    print("✅ Score \(level) erfolgreich gesendet (iOS14+)")
                }
            }
        } else {
            // Fallback für iOS <14
            let gcScore = GKScore(leaderboardIdentifier: "Remember_Highscore_Online")
            gcScore.value = Int64(level)
            GKScore.report([gcScore]) { error in
                if let err = error {
                    print("❌ Fehler beim Submit (Legacy):", err.localizedDescription)
                } else {
                    print("✅ Score \(level) erfolgreich gesendet (Legacy)")
                }
            }
        }
    }
    
    /// Delegate-Callback: schließt den Game Center Controller
    func gameCenterViewControllerDidFinish(_ controller: GKGameCenterViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /// Zeigt das Game Center Leaderboard an
    func showLeaderboard() {
        guard isAuthenticated else { return }
        
        // iOS-14+ Initializer, ersetzt viewState/leaderboardIdentifier
        let gcVC: GKGameCenterViewController
        if #available(iOS 14.0, *) {
            gcVC = GKGameCenterViewController(
                leaderboardID: "Remember_Highscore_Online",
                playerScope: .global,
                timeScope: .allTime
            )
        } else {
            // Fallback auf alte API
            gcVC = GKGameCenterViewController(state: .leaderboards)
            gcVC.leaderboardIdentifier = "Remember_Highscore_Online"
        }
        
        gcVC.gameCenterDelegate = self
        DispatchQueue.main.async {
            UIApplication.rootViewController?
                .present(gcVC, animated: true)
        }
    }
}

