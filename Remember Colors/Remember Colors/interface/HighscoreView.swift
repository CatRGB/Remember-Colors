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
    
    // Lokaler Manager
    @StateObject private var localManager = HighscoreManager.shared
    // Game Center Manager
    @StateObject private var gcManager = GameCenterManager.shared
    
    var body: some View {
        ZStack {
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
                    VStack {
                        List {
                            ForEach(localManager.highscore) { hs in
                                Text("Level \(hs.level) – \(hs.date.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(
                                        LinearGradient(
                                            colors: [.red, .green, .blue, .yellow],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing),
                                            lineWidth: 3)
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
                                        lineWidth: 6
                                )
                            )
                        .padding(.horizontal)
                    }
                    
                    .tabItem {
                        Label("Lokal", systemImage: "person.circle")
                    }
                    
                    // Online Highscores
                    VStack {
                        List {
                            if gcManager.topScores.isEmpty {
                                Text("Keine Daten")
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(gcManager.topScores, id: \.player) { score in
                                    HStack {
                                        Text("\(score.player.displayName)  Hisghscore:")
                                            .font(.headline)
                                            .foregroundStyle(.gray)
                                        Spacer()
                                        Text("\(score.value)")
                                            .bold()
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            LinearGradient(
                                                colors: [.red, .green, .blue, .yellow],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing),
                                                lineWidth: 3)
                                )
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
                                        lineWidth: 6
                                )
                            )
                        .padding(.horizontal)
                    }
                    .tabItem {
                        Label("Online", systemImage: "square.and.arrow.up")
                    }
                }
                
                HStack(spacing: 40) {
                    Button("") {
                        withAnimation { startPressed = true }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation { navigateToContentView = true }
                        }
                    }
                    .buttonStyle(backButton())
                    
                    Button("Game Center") {
                        gcManager.showLeaderboard()
                    }
                    .buttonStyle(sharedButton())
                }
                .padding(.bottom, 50)
            }
            .opacity(startPressed ? 0 : 1)
            .offset(y: startPressed ? -UIScreen.main.bounds.height : 0)
            .animation(.easeInOut, value: startPressed)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // optional: beim Öffnen direkt laden
            gcManager.fetchTopScores(limit: 10)
        }
    }
}

#Preview {
    HighscoreView()
}
