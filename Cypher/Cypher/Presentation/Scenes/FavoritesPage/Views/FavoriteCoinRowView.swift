//
//  FavoriteCoinRowView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 27.01.25.
//

import SwiftUI

struct FavoriteCoinRowView: View {
    let coin: FavoriteCoin
    
    var body: some View {
        HStack {
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
                Text("\(coin.changePercentage24h >= 0 ? "+" : "")\(String(format: "%.2f", coin.changePercentage24h))%")
                    .font(Fonts.semiBold.size(18))
                    .foregroundColor(coin.changePercentage24h >= 0 ? Color(AppColors.green.rawValue) : Color(AppColors.red.rawValue))
                Text("$\(String(format: "%.2f", coin.currentPrice))")
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
