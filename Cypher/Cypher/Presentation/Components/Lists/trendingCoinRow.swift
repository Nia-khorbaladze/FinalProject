//
//  TrendingCoinRow.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct TrendingCoinRow: View {
    let coin: CoinResponse
    let onCoinTap: (CoinResponse) -> Void

    var body: some View {
        HStack(spacing: 16) {
            if let image = coin.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            } else {
                Image(systemName: "bitcoinsign.circle")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.gray.opacity(0.3)))
                    .padding(.trailing, 10)
            }
            
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
                Text(String(format: "%.2f $", coin.currentPrice))
                    .font(Fonts.medium.size(15))
                    .foregroundStyle(Color(AppColors.white.rawValue))
                Text(String(format: "%.2f%%", coin.priceChangePercentage24h ?? 0))
                    .font(Fonts.regular.size(16))
                    .foregroundColor(coin.priceChangePercentage24h ?? 0 >= 0 ? Color(AppColors.green.rawValue) : Color(AppColors.red.rawValue))
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
