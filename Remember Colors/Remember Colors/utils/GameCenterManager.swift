//
//  GameCenterManager.swift
//  Remember Colors
//
//  Created by Josi Salehi on 03.05.25.
//

import Foundation
import GameKit

class GameCenterManager: NSObject, ObservableObject, GKGameCenterControllerDelegate {
    
    static let shared = GameCenterManager()
    
    @Published var isAuthenticated = false
    
    private override init() {
        super.init()
        authenticatePlayer()
    }
    
    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = { gcAutVC, error in
            if let vc = gcAutVC {
                // Game Center Login-Screen zeigen
                DispatchQueue.main.async {
                    UIApplication.shared.windows.first?.rootViewController?
                        .present(vc, animated: true)
                }
            } else if localPlayer.isAuthenticated {
                self.isAuthenticated = true
                print("✅ Game Center: Authentifiziert")
            } else {
                self.isAuthenticated = false
                print("❌ Game Center Fehler: \(error?.localizedDescription ?? "Quest")")
            }
        }
    }
    
    // Meldet einen neuen Highscore (besten Score) an Game Center
    func submitScore(_ level: Int) {
        guard isAuthenticated else {
            print("⚠️ Nicht bei GC angemeldet – Score nicht gesendet")
            return
        }
        let gcScore = GKScore(leaderboardIdentifier: "Remember_Highscore_Online")
        gcScore.value = Int64(level)
        GKScore.report([gcScore]) { error in
            if let error = error {
                print("❌ Score nicht gesendet: \(error.localizedDescription)")
            } else {
                print("✅ Score \(level) an GC gesendet")
            }
        }
    }
    //
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func showLeaderbord() {
        guard isAuthenticated else { return }
        let gcVC = GKGameCenterViewController()
        gcVC.gameCenterDelegate = self
        gcVC.viewState = .leaderboards
        gcVC.leaderboardIdentifier = "Remember_Highscore_Online"
        DispatchQueue.main.async {
            UIApplication.shared.windows.first?.rootViewController?
                .present(gcVC, animated: true)
        }
    }
    
}
