//
//  HomePageViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import Foundation

final class HomePageViewModel {
    let trendingCoins = [
        Coin(name: "Bitcoin", symbol: "BTC", price: 70982.0, changePercentage: -0.39, icon: "bitcoinsign.circle"),
        Coin(name: "Ethereum", symbol: "ETH", price: 3463.27, changePercentage: 3.55, icon: "e.circle"),
        Coin(name: "BNB", symbol: "BNB", price: 707.69, changePercentage: -0.03, icon: "circle.fill"),
        Coin(name: "XRP", symbol: "XRP", price: 2.38, changePercentage: 9.70, icon: "x.circle"),
        Coin(name: "Solana", symbol: "SOL", price: 206.61, changePercentage: 8.48, icon: "s.circle"),
        Coin(name: "Dogecoin", symbol: "DOGE", price: 0.34, changePercentage: 5.97, icon: "d.circle")
    ]
}
