//
//  SwapViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI
import Combine

class SwapViewModel: ObservableObject {
    @Published var isButtonActive: Bool = false
    @Published var receiveAmount: String = "0"
    @Published var payAmount: String = "0" {
        didSet {
            isButtonActive = (Double(payAmount) ?? 0) > 0
        }
    }
    
    let coins = [
        Coin(name: "Bitcoin", symbol: "BTC", price: 70982.0, changePercentage: -0.39, icon: "bitcoinsign.circle"),
        Coin(name: "Ethereum", symbol: "ETH", price: 3463.27, changePercentage: 3.55, icon: "e.circle"),
        Coin(name: "BNB", symbol: "BNB", price: 707.69, changePercentage: -0.03, icon: "circle.fill"),
        Coin(name: "XRP", symbol: "XRP", price: 2.38, changePercentage: 9.70, icon: "x.circle"),
        Coin(name: "Solana", symbol: "SOL", price: 206.61, changePercentage: 8.48, icon: "s.circle"),
        Coin(name: "USDC", symbol: "USDC", price: 1.0, changePercentage: 0.0, icon: "dollarsign.circle")
    ]
}

