//
//  SearchPageView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SearchPageView: View {
    @State private var searchText = ""
    let coins = [
        Coin(name: "Bitcoin", symbol: "BTC", price: 70982.0, changePercentage: -0.39, icon: "bitcoinsign.circle"),
        Coin(name: "Ethereum", symbol: "ETH", price: 3463.27, changePercentage: 3.55, icon: "e.circle"),
        Coin(name: "BNB", symbol: "BNB", price: 707.69, changePercentage: -0.03, icon: "circle.fill"),
        Coin(name: "XRP", symbol: "XRP", price: 2.38, changePercentage: 9.70, icon: "x.circle"),
        Coin(name: "Solana", symbol: "SOL", price: 206.61, changePercentage: 8.48, icon: "s.circle"),
        Coin(name: "Dogecoin", symbol: "DOGE", price: 0.34, changePercentage: 5.97, icon: "d.circle")
    ]
    
    var filteredCoins: [Coin] {
        if searchText.isEmpty {
            return coins
        } else {
            return coins.filter {
                $0.name.lowercased().contains(searchText.lowercased()) ||
                $0.symbol.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
            trendingCoinsView(for: filteredCoins) { coin in
                print("\(coin.name)")
            }
            Spacer()
        }
        .background(Color(AppColors.backgroundColor.rawValue))
        .edgesIgnoringSafeArea(.bottom)
    }
}
