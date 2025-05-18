//
//  SettingView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 29.04.25.
//

import SwiftUI
import SwiftData


struct SettingView: View {
    
    @State private var atmungszeit = false
    @State private var isVibrationLocked = false
    
    // Schwirgkeit
    @State private var selectedDifficulty: Difficulty = .light
    
    // Navigation
    @State private var startPressed = false
    @State private var navigateToContentView = false
    @State private var navigateToCreditsView = false
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    
    var body: some View {
        ZStack {
            if navigateToContentView {
                StartUI()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
            if navigateToCreditsView{
                Credits()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }
            
            VStack(spacing: 20) {
                Text("Settings")
                    .modifier(TitleStyle())
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                
                
                LazyVGrid(columns: columns, spacing: 30) {
                    Button("Bewerten") {
                        // Soll die Apple App Page
                    }
                    .buttonStyle(rateSettingButton())
                    
                    Button("CREDITS") {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            startPressed = true
                        }
                        // Verzögerung und dann Navigation zu ContentView
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                navigateToCreditsView = true
                            }
                        }
                    }
                    .buttonStyle(creditsSettingButton())
                }
                .padding(.top, 20)
                
                HStack(spacing: 20) {
                    
                    Button("VIBRAION") {
                        isVibrationLocked.toggle()
                    }
                    .buttonStyle(vibrationSettingButton(isVibrationLocked: isVibrationLocked))
                }
                .padding(.bottom, 10)
                
                
                
                
                VStack(spacing: 20) {
                    Button("") {
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
                    .padding(.top, 30)
                    .buttonStyle(backButton())
                }
                
                Spacer()
            }
            .opacity(startPressed ? 0 : 1) // Buttons und Text blenden aus, wenn Start gedrückt
            .offset(y: startPressed ? -UIScreen.main.bounds.height : 0) // Gleiten nach oben
            .animation(.easeInOut(duration: 0.5), value: startPressed)
        }
        .zIndex(startPressed ? 0 : 1) // UI nach außen gleiten lassen
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SettingView()
}

