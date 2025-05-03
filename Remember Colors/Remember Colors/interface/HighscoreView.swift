//
//  HighscoreView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 02.05.25.
//

import SwiftUI

struct HighscoreView: View {
    
    // Navigation
    @State private var startPressed = false
    @State private var navigateToContentView = false
    
    @StateObject private var highscoreManager = HighscoreManager.shared
    
    var body: some View {
        ZStack {
            if navigateToContentView {
                StartUI()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }

            VStack {
                Text("Highscore")
                    .modifier(TitleStyle())
                    .padding(.top, 60)
                    .padding(.bottom, 10)

                List {
                    ForEach(highscoreManager.highscore) { score in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Level: \(score.level)")
                                .font(.headline)
                            Text("Am: \(score.date.formatted(date: .abbreviated, time: .shortened))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
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

                HStack(spacing: 160) {
                    Button("") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            startPressed = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                navigateToContentView = true
                            }
                        }
                    }
                    .buttonStyle(backButton())
                    .padding(.bottom, 40)
                    
                    Button("Game Center") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                
                            }
                        }
                    }
                    .buttonStyle(sharedButton())
                    .padding(.bottom, 40)
                }
            }
            .opacity(startPressed ? 0 : 1)
            .offset(y: startPressed ? -UIScreen.main.bounds.height : 0)
            .animation(.easeInOut(duration: 0.5), value: startPressed)
        }
        .zIndex(startPressed ? 0 : 1)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    HighscoreView()
}
