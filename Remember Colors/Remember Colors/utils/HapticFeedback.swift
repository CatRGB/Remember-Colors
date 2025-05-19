//
//  HapticFeedback.swift
//  Remember Colors
//
//  Created by Josi Salehi on 19.05.25.
//

import UIKit
import SwiftUICore

func triggerHaptic(intensity: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    let generator = UIImpactFeedbackGenerator(style: intensity)
    generator.prepare()
    generator.impactOccurred()
}

func feedbackStyle(for color: Color) -> UIImpactFeedbackGenerator.FeedbackStyle {
    switch color {
    case .red:     return .heavy
    case .green:   return .medium
    case .blue:    return .light
    case .yellow:  return .rigid

    case .purple:  return .soft
    case .orange:  return .medium
    case .pink:    return .light
    case .cyan:    return .soft
    case .mint:    return .light
    case .indigo:  return .rigid
    case .teal:    return .medium
    case .brown:   return .heavy
    case .gold:    return .rigid
    case .gray:    return .soft
    case .silver:  return .medium
    case .bronze:  return .light

    default:       return .medium
    }
}

