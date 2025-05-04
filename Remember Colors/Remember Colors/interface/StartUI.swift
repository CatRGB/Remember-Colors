//
//  StartUI.swift
//  Remember Colors
//
//  Created by Josi Salehi on 28.04.25.
//

import SwiftUI

struct StartUI: View {
    
    @State private var navigateToContentView = false
    @State private var navigateToSettingsView = false
    @State private var navigateToHighscoreView = false
    @State private var startPressed = false
    
    // GameCenterManager
    @EnvironmentObject private var gcManager: GameCenterManager
    
    var body: some View {
        ZStack {
            if !gcManager.isAuthenticated {
               
            } else {
                // ContentView anzeigen, wenn navigiert
                if navigateToContentView {
                    ContentView()
                        .transition(.move(edge: .trailing)) // Übergang für ContentView
                        .zIndex(1) // Sicherstellen, dass ContentView oben angezeigt wird
                }
                if navigateToSettingsView {
                    SettingView()
                        .transition(.move(edge: .trailing)) // Übergang für ContentView
                        .zIndex(1) // Sicherstellen, dass ContentView oben angezeigt wird
                }
                
                if navigateToHighscoreView {
                    HighscoreView()
                        .transition(.move(edge: .trailing))
                        .zIndex(1)
                }
                
                VStack {
                    Text("Remember Colors")
                        .modifier(TitleStyle())
                        .opacity(startPressed ? 0 : 1) // Text blendet aus, wenn Start gedrückt
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    // Buttons Bereich
                    VStack {
                        Button("- Start -") {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                startPressed = true
                            }
                            // Verzögerung und dann Navigation zu ContentView
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation {
                                    navigateToContentView = true
                                }
                            }
                        }
                        .buttonStyle(WaveEfect())
                        .padding(.bottom, 200)
                        
                        HStack {
                            Button("") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    startPressed = true
                                }
                                // Verzögerung und dann Navigation zu ContentView
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        navigateToSettingsView = true
                                    }
                                }
                            }
                            .buttonStyle(SettingsButton())
                            
                            Button("") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    startPressed = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation {
                                        navigateToHighscoreView = true
                                    }
                                }
                            }
                            .buttonStyle(HighscoreButton())
                            .padding(.leading, 50)
                            
                            Button("") {
                            }
                            .buttonStyle(punkteShopButton())
                            .padding(.leading, 50)
                        }
                        .padding(.bottom, 70)
                    }
                    .opacity(startPressed ? 0 : 1) // Buttons und Text blenden aus, wenn Start gedrückt
                    .offset(y: startPressed ? -UIScreen.main.bounds.height : 0) // Gleiten nach oben
                    .animation(.easeInOut(duration: 0.5), value: startPressed)
                }
                .zIndex(startPressed ? 0 : 1) // UI nach außen gleiten lassen
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    StartUI()
}
