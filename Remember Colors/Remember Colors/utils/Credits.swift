//
//  Credits.swift
//  Remember Colors
//
//  Created by Josi Salehi on 29.04.25.
//

import SwiftUI

struct Credits: View {
    
    @State private var offset: CGFloat = UIScreen.main.bounds.height
    @State private var navigateToSettingsView = false

    var body: some View {
        ZStack {
            if navigateToSettingsView {
                SettingView()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            } else {
                VStack {
                    Spacer()

                    Text("""
                    Danke an alle, die mir bei diesem Projekt geholfen und mich unterstützt haben.
                                        
                    Vielen Dank auch an die Tester:

                    - Meine Familie
                    - Jonah Richter
                    - Tee ☕  
                    - Und meiner Geduld!
                                        
                    🐉✨ Remember Colors ✨🐉
                    """)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                    .offset(y: offset)
                    .onAppear {
                        // Starte Scrollanimation
                        withAnimation(.linear(duration: 30)) {
                            offset = -UIScreen.main.bounds.height
                        }
                        // Nach 22 Sekunden navigieren (etwas Puffer nach der Animation)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 25) {
                            withAnimation {
                                navigateToSettingsView = true
                            }
                        }
                    }

                    Spacer()
                }
            }
        }
    }
}
#Preview {
    Credits()
}
