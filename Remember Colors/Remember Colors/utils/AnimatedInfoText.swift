//
//  AnimationInfoText.swift
//  Remember Colors
//
//  Created by Josi Salehi on 27.04.25.
//

import SwiftUI

struct AnimatedInfoText: View {
    
    var text: String
    var animateSuccess: Bool
    
    
    var body: some View {
        Text(text)
            .font(.title)
            .scaleEffect(animateSuccess ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.3), value: animateSuccess)
            
    }
}

#Preview {
    AnimatedInfoText(text: "Level: 1 geschaft", animateSuccess: true)
}
