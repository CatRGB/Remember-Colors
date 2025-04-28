//
//  StartUI.swift
//  Remember Colors
//
//  Created by Josi Salehi on 28.04.25.
//

import SwiftUI

struct StartUI: View {
    
    @State private var navigateToContentView = false
    
    var body: some View {
        Text("Remember Colors")
            .modifier(TitleStyle())

        
        VStack {
            Button("Start") {
                
            }
            .buttonStyle(WaveEfect())
            
        }
        .padding(.top, 400)
        Spacer()
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
    }
}

#Preview {
    StartUI()
}
