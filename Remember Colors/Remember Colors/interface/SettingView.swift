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
    @State private var soundeffekte = false
    @State private var bildschiermrotation = false
    
    var body: some View {
        Text("Settings")
            .modifier(TitleStyle())
        Spacer()
        
        VStack {
            Button("TITLE MUSIK") {
                
            }
            
            Button("SOUND EFFECTS") {
                
            }
            
            Button("BILDSCHIERMROTATION") {
            
            }
            
            Button("CREDITS") {
                
            }
        }
        
    }
}

#Preview {
    SettingView()
}

