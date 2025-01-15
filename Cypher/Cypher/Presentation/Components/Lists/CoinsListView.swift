//
//  TrendingCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import SwiftUI

struct CoinsListView: View {
    let coins: [Coin]
    let title: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(Fonts.bold.size(20))
                    .foregroundStyle(Color(AppColors.white.rawValue))
                    .padding(.horizontal)
                    .padding(.top)

                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(coins, id: \.symbol) { coin in
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
            .frame(maxWidth: .infinity, alignment: .topLeading) 
        }
        .background(Color.clear)
    }
}

