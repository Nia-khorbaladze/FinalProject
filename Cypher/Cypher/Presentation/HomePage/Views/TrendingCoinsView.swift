//
//  TrendingCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import SwiftUI

struct TrendingCoinsView: View {
    let trendingCoins = [
        Coin(name: "Bitcoin", symbol: "BTC", price: 70982.0, changePercentage: -0.39, icon: "bitcoinsign.circle"),
        Coin(name: "Ethereum", symbol: "ETH", price: 3463.27, changePercentage: 3.55, icon: "e.circle"),
        Coin(name: "BNB", symbol: "BNB", price: 707.69, changePercentage: -0.03, icon: "circle.fill"),
        Coin(name: "XRP", symbol: "XRP", price: 2.38, changePercentage: 9.70, icon: "x.circle"),
        Coin(name: "Solana", symbol: "SOL", price: 206.61, changePercentage: 8.48, icon: "s.circle"),
        Coin(name: "Dogecoin", symbol: "DOGE", price: 0.34, changePercentage: 5.97, icon: "d.circle")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Trending")
                .font(Fonts.bold.size(20))
                .foregroundStyle(Color(AppColors.white.rawValue))
                .padding(.horizontal)
                .padding(.top)
            
            LazyVStack(spacing: 0) {
                ForEach(trendingCoins, id: \.symbol) { coin in
                    HStack {
                        Image(systemName: coin.icon)
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.gray.opacity(0.3)))
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(coin.name)
                                .font(Fonts.medium.size(18))
                                .foregroundColor(Color(AppColors.white.rawValue))
                            Text(coin.symbol)
                                .font(Fonts.medium.size(13))
                                .foregroundColor(Color(AppColors.lightGrey.rawValue))
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("\(String(format: "%.2f", coin.changePercentage))%")
                                .font(Fonts.semiBold.size(18))
                                .foregroundColor(coin.changePercentage >= 0 ? Color(AppColors.green.rawValue) : Color(AppColors.red.rawValue))
                            Text("$\(String(format: "%.2f", coin.price))")
                                .font(Fonts.medium.size(13))
                                .foregroundColor(Color(AppColors.lightGrey.rawValue))
                        }
                    }
                    .padding()
                    .background(Color(AppColors.greyBlue.rawValue))
                    .cornerRadius(15)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 10)
                }
            }
        }
        .background(Color.clear)
    }
}

