//
//  HapticTestView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 19.05.25.
//

import SwiftUI
import UIKit

struct HapticTestView: View {
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        VStack (spacing: 10) {
            Text("Haptic Testen")
                .modifier(TitleStyle())
            
            HStack(spacing: 20) {
                testButton(label: "Leicht", style: .light, scaleAmount: 1.05)
                testButton(label: "Mittel", style: .medium, scaleAmount: 1.15)
                testButton(label: "Stark", style: .heavy, scaleAmount: 1.25)
            }
        }
        .padding()
        //.background(Color.gray.opacity(0.1))
        //.cornerRadius(12)
    }
    
    func testButton(label: String, style: UIImpactFeedbackGenerator.FeedbackStyle, scaleAmount: CGFloat) -> some View {
            Button(label) {
                triggerHaptic(intensity: style)
                withAnimation(.easeOut(duration: 0.2)) {
                    scale = scaleAmount
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn(duration: 0.2)) {
                        scale = 1.0
                    }
                }
            }
            .padding(8)
            .background(Color.blue.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(scale)
    }
    
    func triggerHaptic(intensity: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: intensity)
        generator.prepare()
        generator.impactOccurred()
    }
}
#Preview {
    HapticTestView()
}
