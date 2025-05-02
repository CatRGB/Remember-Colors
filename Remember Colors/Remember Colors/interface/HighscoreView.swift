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
                
                VStack(spacing: 20) {
                    List(0..<30) {
                        Text("Heigscores: \($0)")
                    }
                    
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
                }
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
    HighscoreView()
}
