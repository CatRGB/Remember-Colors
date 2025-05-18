//
//  HighscoreView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 02.05.25.
//

import SwiftUI
import GameKit

struct HighscoreView: View {
    
    @State private var startPressed = false
    @State private var navigateToContentView = false
    
    // Manager holen
    @StateObject private var localManager = HighscoreManager.shared
    @StateObject private var gcManager    = GameCenterManager.shared
    
    var body: some View {
        ZStack {
            // Dein Start-UI (wie gehabt)
            if navigateToContentView {
                StartUI()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
            
            VStack(spacing: 20) {
                Text("Highscores")
                    .modifier(TitleStyle())
                    .padding(.top, 60)

                TabView {
                    // Lokale Scores
                    localHighscores
                        .tabItem { Label("Lokal", systemImage: "person.circle") }
                    
                    // Online Scores
                    onlineHighscores
                        .tabItem { Label("Online", systemImage: "trophy") }
                    
                    // Achivements
                    onlineAchievement
                        .tabItem { Label("Achievements", systemImage: "star") }
                }
                
                actionButtons
                    .padding(.bottom, 50)
            }
            .opacity(startPressed ? 0 : 1)
            .offset(y: startPressed ? -UIScreen.main.bounds.height : 0)
            .animation(.easeInOut, value: startPressed)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            gcManager.fetchTopScores(limit: 10)
        }
    }
    
    // MARK: - Subviews
    
    private var localHighscores: some View {
        List(localManager.highscore) { hs in
            HStack(spacing: 20) {
                Text("Level \(hs.level)")
                    .font(.headline)
                Text(hs.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(
                            colors: [.red, .green, .blue, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
            )
        }
        .scrollContentBackground(.hidden)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    LinearGradient(
                        colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 3
                )
        )
        .padding()
        .listStyle(.plain)
    }
    
    private var onlineHighscores: some View {
        VStack {
            List {
                if gcManager.topScores.isEmpty {
                    Text("Keine Daten").foregroundColor(.gray)
                } else {
                    ForEach(gcManager.topScores, id: \.playerID) { score in
                        HStack {
                            Text(score.player.displayName)
                                    .font(.subheadline)
                            Spacer()
                            Text("\(score.value)")
                                .bold()
                        }
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        colors: [.red, .green, .blue, .yellow],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        )
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(
                            colors: [.red, .green, .blue, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
            )
            .padding()
            .listStyle(.plain)
        }
    }
    
    private var onlineAchievement: some View {
        VStack {
            List {
                if gcManager.achievmets.isEmpty {
                    Text("Keine Achievements gefunden").foregroundColor(.gray)
                } else {
                    ForEach(gcManager.achievmets, id: \.identifier) { achievement in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(achievement.identifier)
                                    .font(.headline)
                                Text("\(Int(achievement.percentComplete)) % abgeschlossen")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            
                            if achievement.isCompleted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    LinearGradient(
                                        colors: [.red, .green, .blue, .yellow],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 3
                                )
                        )
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(
                            colors: [.red, .green, .blue, .yellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 3
                    )
            )
            .padding()
            .listStyle(.plain)
        }
    }
    
    private var actionButtons: some View {
        HStack(spacing: 40) {
            Button("") {
                withAnimation { startPressed = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { navigateToContentView = true }
                }
            }
            .buttonStyle(backButton())
        }
    }
}

#Preview {
    HighscoreView()
}
