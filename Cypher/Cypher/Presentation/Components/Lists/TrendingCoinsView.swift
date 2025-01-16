//
//  TrendingCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

func trendingCoinsView(for coins: [Coin], onCoinTap: @escaping (Coin) -> Void) -> some View {
    VStack(alignment: .leading) {
        Text("Trending Coins")
            .font(Fonts.bold.size(24))
            .foregroundStyle(Color(AppColors.white.rawValue))
            .padding(.leading, 20)
        
        List(coins) { coin in
            HStack(spacing: 16) {
                Image(systemName: coin.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(coin.name)
                        .font(Fonts.medium.size(18))
                        .foregroundStyle(Color(AppColors.white.rawValue))
                    Text(coin.symbol)
                        .font(Fonts.medium.size(13))
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(String(format: "%.2f $", coin.price))
                        .font(Fonts.medium.size(15))
                        .foregroundStyle(Color(AppColors.white.rawValue))
                    Text(String(format: "%.2f%%", coin.changePercentage))
                        .font(Fonts.regular.size(16))
                        .foregroundColor(coin.changePercentage >= 0 ? Color(AppColors.green.rawValue) : Color(AppColors.red.rawValue))
                }
            }
            .padding(.vertical, 8)
            .listRowSeparator(.hidden)
            .contentShape(Rectangle())
            .onTapGesture {
                onCoinTap(coin)
            }
            .listRowBackground(Color(AppColors.backgroundColor.rawValue))
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }
    .background(Color(AppColors.backgroundColor.rawValue))
}
