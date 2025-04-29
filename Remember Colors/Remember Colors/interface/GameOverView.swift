//
//  GameOverView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 29.04.25.
//

import SwiftUI

struct GameOverView: View {
    let onRestart: () -> Void
    let onBackToStart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("Game Over")
                .modifier(TitleStyle())

            Button("") {
                onRestart()
            }
            .buttonStyle(playToButton())

            Button("") {
                onBackToStart()
            }
            .buttonStyle(backButton())
        }
    }
}

