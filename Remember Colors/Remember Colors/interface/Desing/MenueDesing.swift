//
//  MenueDesing.swift
//  Remember Colors
//
//  Created by Josi Salehi on 28.04.25.
//

import SwiftUI

extension Color {
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 40, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.red, .green, .blue, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: .black, radius: 10, x: 5, y: 5)
    }
}

struct WaveEfect: ButtonStyle {
    @State private var waveEffect: CGFloat = 0
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 30, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.red, .green, .blue, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .offset(x: waveEffect, y: 0)
            .rotationEffect(.degrees(Double(waveEffect * 5))) // Gradwert berechnung
            .animation(
                Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: waveEffect
            )
            .onAppear {
                self.waveEffect = 2 // Höhe der Wellenbewegung
            }
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .shadow(color: .blue, radius: 5, y: 5)
    }
}

struct FlipButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
    }
}

struct SettingsButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "gear")
            .padding(10)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .gray, radius: 5, y: 5)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
    }
}

struct HighscoreButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image(systemName: "flame")
            .padding(10)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .red, radius: 5, y: 5)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
    }
}

struct DifficultyButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image(systemName: "trophy")
            .padding(10)
            .background(Color.gold)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .gold, radius: 5, y: 5)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
    }
}

struct punkteShopButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image(systemName: "cart")
            .padding(10)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .yellow, radius: 5, y: 5)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
    }
}
