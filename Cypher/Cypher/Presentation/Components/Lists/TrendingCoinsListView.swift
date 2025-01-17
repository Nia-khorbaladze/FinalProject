//
//  TrendingCoinsListView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct TrendingCoinsListView: View {
    let trendingCoins = [
        Coin(name: "Bitcoin", symbol: "BTC", price: 70982.0, changePercentage: -0.39, icon: "bitcoinsign.circle"),
        Coin(name: "Ethereum", symbol: "ETH", price: 3463.27, changePercentage: 3.55, icon: "e.circle"),
        Coin(name: "BNB", symbol: "BNB", price: 707.69, changePercentage: -0.03, icon: "circle.fill"),
        Coin(name: "XRP", symbol: "XRP", price: 2.38, changePercentage: 9.70, icon: "x.circle"),
        Coin(name: "Solana", symbol: "SOL", price: 206.61, changePercentage: 8.48, icon: "s.circle"),
        Coin(name: "Dogecoin", symbol: "DOGE", price: 0.34, changePercentage: 5.97, icon: "d.circle")
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Trending Coins")
                .font(Fonts.bold.size(24))
                .foregroundStyle(Color(AppColors.white.rawValue))
                .padding(.leading, 20)
            trendingCoinsView(for: trendingCoins) { coin in
                print("..")
            }
            .frame(maxWidth: .infinity, minHeight: 400)
            .background(Color.clear)
        }
    }
}
