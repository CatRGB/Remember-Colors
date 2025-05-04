//
//  GameCenterView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 04.05.25.
//

import SwiftUI
import GameKit


// SwiftUI-Wrapper, um das Game Center Leaderboard als Sheet anzuzeigen
struct GameCenterView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some GKGameCenterViewController {
        let gcVC = GKGameCenterViewController(
            leaderboardID: "Remember_Highscore_Online",
            playerScope: .global,
            timeScope: .allTime
        )
        
        gcVC.gameCenterDelegate = GameCenterManager.shared
        return gcVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // hier nichts weiter tun
    }
}
