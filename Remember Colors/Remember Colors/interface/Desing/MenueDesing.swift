//
//  MenueDesing.swift
//  Remember Colors
//
//  Created by Josi Salehi on 28.04.25.
//

import SwiftUI

enum Difficulty {
    case light, normal, heavy
    
    var color: Color {
        switch self {
        case .light:
            return .bronze
        case .normal:
            return .silver
        case .heavy:
            return .gold
        }
    }
    
    var darkColor: Color {
        switch self {
        case .light:
            return .darkBronze
        case .normal:
            return .darkSilver
        case .heavy:
            return .darkGold
        }
    }
    
}


extension Color {
    static let gold = Color(red: 1.0, green: 0.84, blue: 0.0)
    static let silver = Color(red: 0.78, green: 0.78, blue: 0.82)
    static let bronze = Color(red: 0.82, green: 0.52, blue: 0.0)
    
    static let darkGold = Color(red: 0.7, green: 0.59, blue: 0.0)
    static let darkSilver = Color(red: 0.55, green: 0.55, blue: 0.58)
    static let darkBronze = Color(red: 0.58, green: 0.37, blue: 0.0)
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
            //.shadow(color: .black, radius: 10, x: 5, y: 5)
    }
}

struct HighscoreListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 25, weight: .bold))
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.red, .green, .blue, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            //.shadow(color: .black, radius: 10, x: 5, y: 5)
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

struct ContinuousBounce: ViewModifier {
    @State private var animate = false
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(animate ? 1.3 : 1.0)
            .foregroundStyle(
                LinearGradient(
                    gradient: Gradient(colors: [.red, .green, .blue, .yellow]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .animation(
                .interpolatingSpring(stiffness: 200, damping: 10)
                    .repeatForever(autoreverses: true),
                value: animate
            )
            .onAppear {
                animate = true
            }
    }
}

struct ContinuousJolt: ViewModifier {
    @State private var animate = false
    
    func body(content: Content) -> some View {
        content
            .offset(x: animate ? 15 : 0)
            .animation(
                .interpolatingSpring(stiffness: 300, damping: 5)
                    .repeatForever(autoreverses: true),
                value: animate
            )
            .onAppear {
                animate = true
            }
    }
}

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .frame(width: 50, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .shadow(color: .blue, radius: 5, y: 5)
    }
}

struct SettingsButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "gear")
            .frame(width: 30, height: 30)
            .padding(10)
            .background(Color.darkSilver)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
                .foregroundColor(.gray)
            )
    }
}

struct HighscoreButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image(systemName: "flame")
            .frame(width: 30, height: 30)
            .padding(10)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct punkteShopButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            Image(systemName: "cart")
            .frame(width: 30, height: 30)
            .padding(10)
            .background(Color.yellow)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct backButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "door.left.hand.open")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct playToButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "memories")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .rotation3DEffect(
                Angle(degrees: configuration.isPressed ? 180 : 0), axis: (x: 0, y: 1, z: 0)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}


struct titleMusicSettingButton: ButtonStyle {
    var isTitleMusicLocked = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "music.quarternote.3")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(isTitleMusicLocked ? Color.red : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct soundEffectsSettingButton: ButtonStyle {
    var isSoundeffekteLocked = false
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "speaker")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(isSoundeffekteLocked ? Color.red : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct rateSettingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "suit.heart")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct creditsSettingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "person")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}


struct LightnessButton: ButtonStyle {
    var difficulty: Difficulty
    var isLocked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "chart.line.uptrend.xyaxis")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(isLocked ? difficulty.darkColor : difficulty.color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct NormalButton: ButtonStyle {
    var difficulty: Difficulty
    var isLocked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "chart.line.uptrend.xyaxis")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(isLocked ? difficulty.darkColor : difficulty.color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct HeavyButton: ButtonStyle {
    var difficulty: Difficulty
    var isLocked: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "chart.line.uptrend.xyaxis")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(isLocked ? difficulty.darkColor : difficulty.color)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}

struct sharedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        Image(systemName: "square.and.arrow.up")
            .frame(width: 50, height: 50)
            .padding(10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        LinearGradient(colors: [.red, .green, .blue, .yellow],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 6
                )
            )
    }
}
