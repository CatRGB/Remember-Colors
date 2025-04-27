//
//  ContentView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 27.04.25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var currentPlayer = 0
    @State private var sequenceIndex = 0
    @State private var colorSequence = [Int]()
    @State private var colorsToTap = [Int]()
    @State private var gameEnded = false
    @State private var infoText = "Remember Colours"
    @State private var actionButtonText = "Starte das Spiel!"
    @State private var isActionButtonEnabled = true
    @State private var isUserInteractionEnabled = true
    @State private var gameRunning = false
    @State private var animateSuccess: Bool = false
    
    @StateObject private var levelManager = GameLevelManager()
    
    // Dynamisch Spaltenanzahl
    var gridColumns: [GridItem] {
        let columns = Int(ceil(sqrt(Double(levelManager.colors.count))))
        return Array(repeating: GridItem(.flexible(), spacing: 20), count: columns)
    }
    
    // Dynamische Button-Größe
    var buttonSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let columns = CGFloat(gridColumns.count)
        let spacing: CGFloat = 30
        return (screenWidth - (spacing * (columns + 1))) / columns
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AnimatedInfoText(text: infoText, animateSuccess: animateSuccess)
            
            Spacer()
            
            LazyVGrid(columns: gridColumns, spacing: 20) {
                ForEach(0..<levelManager.colors.count, id: \.self) { index in
                    ColorButton(
                        color: levelManager.colors[index],
                        isHighlighted: levelManager.colorButtonStates[index],
                        size: buttonSize,
                        isEnabled: isUserInteractionEnabled
                    ) {
                        colorButtonHandler(index)
                    }
                }
            }

            Spacer()
            
            Button(action: {
                if !gameRunning {
                    if gameEnded {
                        createNewGame()
                    } else {
                        startNextLevel()
                    }
                }
            }) {
                Text(actionButtonText)
                    .padding()
                    .background(isActionButtonEnabled ? Color.blue : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(!isActionButtonEnabled)
        }
        .padding()
    }
    
    func createNewGame() {
        colorSequence = [Int.random(in: 0..<levelManager.colors.count)]
        colorsToTap = []
        sequenceIndex = 0
        actionButtonText = "Starte das Spiel!"
        isActionButtonEnabled = true
        infoText = "Level: \(sequenceIndex + 1)"
        levelManager.resetColors()
        currentPlayer = 0
        gameRunning = false
        gameEnded = false
    }
    
    func startNextLevel() {
        colorSequence.append(Int.random(in: 0..<levelManager.colors.count))
        colorsToTap = []
        sequenceIndex = 0 // Wichtig: neu starten innerhalb des Levels
        isUserInteractionEnabled = false
        isActionButtonEnabled = false
        infoText = "Level: \(colorSequence.count)" // Level = Anzahl Farben
        gameRunning = true
        playSequence()
    }
    
    func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(buttonIndex: colorSequence[sequenceIndex])
            // sequenceIndex += 1 wird innerhalb von flash() nach playSequence() aufgerufen
        } else {
            colorsToTap = colorSequence
            isUserInteractionEnabled = true
            actionButtonText = "Nimm die nächsten \(colorsToTap.count) Farben wahr!"
            
            for index in levelManager.colorButtonStates.indices {
                levelManager.colorButtonStates[index] = false
            }
        }
    }
    
    func flash(buttonIndex: Int) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            self.levelManager.colorButtonStates[buttonIndex].toggle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.levelManager.colorButtonStates[buttonIndex].toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.sequenceIndex += 1
                self.playSequence()
            }
        }
    }
    
    func endGame() {
        gameRunning = false
        gameEnded = true
        infoText = "Game Over"
        actionButtonText = "Neues Spiel"
        isActionButtonEnabled = true
    }
    
    func colorButtonHandler(_ index: Int) {
        guard !colorsToTap.isEmpty else { return }
        let expectColor = colorsToTap.removeFirst()
        
        if index == expectColor {
            if colorsToTap.isEmpty {
                gameRunning = false
                infoText = "Level \(colorSequence.count) geschafft!"
                actionButtonText = "Weiter zum nächsten Level"
                isActionButtonEnabled = true
                isUserInteractionEnabled = false
                
                // Animation abspielen
                animateSuccess = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animateSuccess = false
                }
            }
        } else {
            endGame()
        }
    }
}

#Preview {
    ContentView()
}
