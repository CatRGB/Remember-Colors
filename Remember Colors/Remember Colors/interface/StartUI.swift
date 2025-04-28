//
//  StartUI.swift
//  Remember Colors
//
//  Created by Josi Salehi on 28.04.25.
//

import SwiftUI

struct StartUI: View {
    
    @State private var navigateToContentView = false
    @State private var startPressed = false
    
    var body: some View {
        ZStack {
            // ContentView anzeigen, wenn navigiert
            if navigateToContentView {
                ContentView()
                    .transition(.move(edge: .trailing)) // Übergang für ContentView
                    .zIndex(1) // Sicherstellen, dass ContentView oben angezeigt wird
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
                        }
                        .buttonStyle(SettingsButton())
                        
                        Button("") {
                        }
                        .buttonStyle(HighscoreButton())
                        .padding(.leading, 50)
                        
                        Button("") {
                        }
                        .buttonStyle(DifficultyButton())
                        .padding(.leading, 10)
                        
                        Button("") {
                        }
                        .buttonStyle(punkteShopButton())
                        .padding(.leading, 50)
                    }
                    .padding(.bottom, 50)
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

#Preview {
    StartUI()
}
