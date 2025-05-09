//
//  ShopView.swift
//  Remember Colors
//
//  Created by Josi Salehi on 06.05.25.
//

import SwiftUI

struct ShopView: View {
    @State private var startPressed = false
    @State private var navigateToStartView = false

    @EnvironmentObject var currentManager: CurrencyManager
    @EnvironmentObject var shopState: ShopState

    var body: some View {
        ZStack {
            if navigateToStartView {
                StartUI()
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }

            VStack {
                // Titel
                Text("Shop")
                    .modifier(TitleStyle())
                    .padding(.top, 50)

                // Coin-Anzeige
                Text("Coins: \(currentManager.coins)")
                    .font(.headline)
                    .padding(.bottom, 20)

                // Shop-Items scrollbar
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(ShopItems.allCases) { item in
                            VStack(spacing: 10) {
                                if let imageName = item.image {
                                    Image(imageName)
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                } else {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 100, height: 100)
                                        .overlay(Text("🎨"))
                                }


                                Text(item.name)
                                    .font(.subheadline)

                                if shopState.isUnlocked(item) {
                                    Text("✅ Gekauft")
                                        .foregroundColor(.green)
                                    if shopState.selectedSkinID == item.id {
                                        Text("🎮 Aktiv")
                                            .foregroundColor(.blue)
                                    } else {
                                        Button("Ausrüsten") {
                                            shopState.selectedSkinID = item.id
                                        }
                                        .buttonStyle(.bordered)
                                    }
                                    
                                } else {
                                    Button("Kaufen für \(item.coins)") {
                                        if currentManager.spendCoins(item.coins) {
                                            shopState.unlock(item)
                                        }
                                    }
                                    .buttonStyle(.borderedProminent)
                                }
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                }

                Spacer()

                // Zurück-Button
                Button("") {
                    withAnimation { startPressed = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation { navigateToStartView = true }
                    }
                }
                .buttonStyle(backButton())
                .padding(.bottom, 30)
            }
            .padding()
            .opacity(startPressed ? 0 : 1)
            .offset(y: startPressed ? -UIScreen.main.bounds.height : 0)
            .animation(.easeInOut, value: startPressed)
        }
        
        .edgesIgnoringSafeArea(.all)
    }
}
#Preview {
    ShopView()
        .environmentObject(CurrencyManager())
        .environmentObject(ShopState())
}
