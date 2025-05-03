//
//  ColorButton.swift
//  Remember Colors
//
//  Created by Josi Salehi on 27.04.25.
//

import SwiftUI

struct ColorButton: View {
    var color: Color
    var isHighlighted: Bool
    var size: CGFloat
    var isEnabled: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Circle()
                .fill(color)
                .frame(width: size, height: size)
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: isHighlighted ? 30 : 0)
                )
                .opacity(isHighlighted ? 0.5 : 1.0)
        }
        .disabled(!isEnabled)
    }
}
