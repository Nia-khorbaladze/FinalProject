//
//  TrendingCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

func trendingCoinsView(for coins: [Coin], onCoinTap: @escaping (Coin) -> Void) -> some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(coins) { coin in
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
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onCoinTap(coin)
                    }
                    .background(Color(AppColors.backgroundColor.rawValue))
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: CGFloat(coins.count) * 50)
        .padding(.horizontal, 20)
    .background(Color(AppColors.backgroundColor.rawValue))
}

