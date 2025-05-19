//
//  ContentView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 27.04.25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentPlayer = 0
    @State private var sequenceIndex = 0
    @State private var colorSequence = [Int]()
    @State private var colorsToTap = [Int]()
    @State private var gameEnded = false
    @State private var infoText = "Remember Colours"
    @State private var actionButtonText = "Starte das Spiel!"
    @State private var backButton = "Zurück"
    @State private var showBackButton: Bool = false
    @State private var isActionButtonEnabled = true
    @State private var isUserInteractionEnabled = true
    @State private var gameRunning = false
    @State private var animateSuccess: Bool = false
    
    @State private var navigateToStartUI = false
    @State private var startPressed = false
    @State private var isFirstLaunch = true

    
    let delayWithNewColor: Double = 1.2
    let delayWithoutNewColor: Double = 0.5
    
    @StateObject private var levelManager = GameLevelManager()
    @ObservedObject private var highscoreManager = HighscoreManager.shared
    @ObservedObject private var gcManager = GameCenterManager.shared
    @StateObject private var currencyManager = CurrencyManager()
    @EnvironmentObject var settingsManager : SettingsManager
    
    @EnvironmentObject var shopState: ShopState
    var selectedSkin: ShopItems? {
        ShopItems(rawValue: shopState.selectedSkinID)
    }


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
        ZStack {
            // Hauptspiel UI
            VStack(spacing: 20) {
                if !gameEnded {
                    AnimatedInfoText(text: infoText, animateSuccess: animateSuccess)
                        .padding(.top, 50)
                        .modifier(TitleStyle())
                }

                Spacer()	

                if !gameEnded {
                    LazyVGrid(columns: gridColumns, spacing: 20) {
                        ForEach(0..<levelManager.colors.count, id: \.self) { index in
                            SkinButton(
                                color: levelManager.colors[index],
                                imageName: selectedSkin?.image,
                                isHighlighted: levelManager.colorButtonStates[index],
                                isNewlyAdded: levelManager.newlyAddedColorIndex == index,
                                size: buttonSize,
                                isEnabled: isUserInteractionEnabled,
                                action: {
                                    colorButtonHandler(index)
                                }
                            )
                            .scaleEffect(levelManager.newlyAddedColorIndex == index ? 1.2 : 1.0)
                            .animation(.easeOut(duration: 0.5), value: levelManager.newlyAddedColorIndex)
                        }
                    }
                    
                    Spacer()
                    if isActionButtonEnabled {
                        Button(action: {
                            startNextLevel()
                        }) {
                            Text(actionButtonText)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .opacity(startPressed ? 0 : 1)
            .offset(y: startPressed ? -UIScreen.main.bounds.height : 0)
            .animation(.easeInOut(duration: 0.5), value: startPressed)
            .padding()
            
            

            // Game Over Overlay
            if gameEnded {
                GameOverView(
                    onRestart: {
                        createNewGame()
                    },
                    onBackToStart: {
                        gameEnded = false
                        withAnimation(.easeIn(duration: 0.5)) {
                            startPressed = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation {
                                navigateToStartUI = true
                            }
                        }
                    }
                )
                .zIndex(1)
            }

            // Start-UI Overlay
            if navigateToStartUI {
                StartUI()
                    .transition(.move(edge: .trailing))
                    .zIndex(2)
            }
        }
        .onAppear {
            print("🎮 Aktiver Skin: \(shopState.selectedSkinID)")
            if isFirstLaunch {
                isFirstLaunch = false
                startNextLevel()
            }
        }
        .edgesIgnoringSafeArea(.all)

    }
    
    func createNewGame() {
        colorSequence = [Int.random(in: 0..<levelManager.colors.count)]
        colorsToTap = []
        sequenceIndex = 0
        infoText = "Level: 1"
        levelManager.resetColors()
        currentPlayer = 0
        gameRunning = false
        gameEnded = false
        isUserInteractionEnabled = false
        isActionButtonEnabled = false
        actionButtonText = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            startNextLevel()
        }
    }

    
    func startNextLevel() {
        // Falls Level erreicht ist: Neue Farbe hinzufügen
        var newColorAdded = false
        if levelManager.levelThresholdsForNewColor.contains(colorSequence.count) {
            levelManager.addNewColors()
            newColorAdded = true
        }
        
        
        
        // Die neue Farbe oder das neue Level vorbereiten
        colorSequence.append(Int.random(in: 0..<levelManager.colors.count))
        colorsToTap = []
        sequenceIndex = 0 // Wichtig: neu starten innerhalb des Levels
        isUserInteractionEnabled = false
        isActionButtonEnabled = false
        infoText = "Level: \(colorSequence.count)" // Level = Anzahl Farben
        gameRunning = true
        
        let delay  = newColorAdded ? delayWithNewColor : delayWithNewColor
       // Wenn neue Farbe dazu kam, erst kurze Pause für Animation
        if newColorAdded {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                levelManager.newlyAddedColorIndex = nil
                playSequence()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                playSequence()
            }
        }
    }
    
    func playSequence() {
        if sequenceIndex < colorSequence.count {
            flash(buttonIndex: colorSequence[sequenceIndex])
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
        if settingsManager.vibrationEnabled {
            let color = levelManager.colors[buttonIndex]
            let style = feedbackStyle(for: color)
            triggerHaptic(intensity: style)
        }

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
        
        let finalScore = colorSequence.count
        highscoreManager.addHighscore(level: finalScore)
        
        let gamePlayedCount = UserDefaults.standard.integer(forKey: "gamePlayedCount") + 1
        UserDefaults.standard.set(gamePlayedCount, forKey: "gamePlayedCount") // ✅ speichern zuerst

        let progress: Double = Double(gamePlayedCount) / 100.0 * 100.0
        
        if gcManager.isAuthenticated {
            GameCenterManager.shared.submitScore(finalScore)
            
            /// 🎯 Achievement: Farb-Legende
            if finalScore >= 50 {
                gcManager.reportAchievementOnce(identifier: "highscore_above_50", percentComplete: 100)
            }
            
            /// 🎯 Achievement: Dranbleiber – 5 Spiele gespielt
            if gamePlayedCount >= 5 {
                gcManager.reportAchievementOnce(identifier: "play_5_games", percentComplete: 100)
            }
            
            /// 🎯 Achievement: Farben-Veteran – Fortschritt (immer melden, nicht nur ab 100)
            gcManager.reportAchievement(identifier: "played_100_games", percentComplete: min(progress, 100.0))
        }
    }
    
    func colorButtonHandler(_ index: Int) {
        guard !colorsToTap.isEmpty else { return }
        let expectColor = colorsToTap.removeFirst()
        
        if index == expectColor {
            if colorsToTap.isEmpty {
                gameRunning = false
                infoText = "Level \(colorSequence.count) geschafft!"
                
                let showContinueButton = colorSequence.count % 5 == 0
                actionButtonText = showContinueButton ? "Weiter zum nächsten Level" : ""
                isActionButtonEnabled = showContinueButton
                isUserInteractionEnabled = false

                animateSuccess = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    animateSuccess = false
                }

                if !showContinueButton {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        startNextLevel()
                    }
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
