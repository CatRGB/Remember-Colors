//
//  SkinButton.swift
//  Remember Colors
//
//  Created by Josi Salehi on 09.05.25.
//

import SwiftUI

struct SkinButton: View {
    
    var color: Color
    var imageName: String? // wenn gesetzt → Bild statt Kreis
    var isHighlighted: Bool
    var isNewlyAdded: Bool = false
    var size: CGFloat
    var isEnabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                if let imageName = imageName {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                        .scaleEffect(
                            isNewlyAdded ? 1.2 : (isHighlighted ? 0.8 : 1.0)
                        )
                        .animation(.easeInOut(duration: 0.3), value: isHighlighted)
                } else {
                    Circle()
                        .fill(color)
                        .frame(width: size, height: size)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: isHighlighted ? 30 : 0)
                        )
                        .scaleEffect(isHighlighted ? 0.8 : 1.0)
                        .animation(.easeInOut(duration: 0.3), value: isHighlighted)
                }
            }

        }
        .disabled(!isEnabled)
        
    }
}
