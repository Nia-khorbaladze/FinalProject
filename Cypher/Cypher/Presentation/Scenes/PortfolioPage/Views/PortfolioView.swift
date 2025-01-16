//
//  PortfolioView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct PortfolioView: View {
    let ownedCoins = [
        OwnedCoin(name: "Solana", symbol: "SOL", amount: "0.0433 SOL", amountInDollar: 8.91, changePercentage: +0.51, icon: "bitcoinsign.circle"),
        OwnedCoin(name: "Bitcoin", symbol: "BTC", amount: "0.0433 BTC", amountInDollar: 8.91, changePercentage: +0.51, icon: "bitcoinsign.circle")
    ]
    var body: some View {
        HStack {
            Text("Portfolio")
                .font(Fonts.bold.size(24))
                .foregroundStyle(Color(AppColors.white.rawValue))
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        
        LazyVStack(alignment: .leading, spacing: 0) {
            ForEach(ownedCoins, id: \.symbol) { coin in
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
                        Text(coin.amount)
                            .font(Fonts.medium.size(13))
                            .foregroundColor(Color(AppColors.lightGrey.rawValue))
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 2) {
                        Text("$\(String(format: "%.2f", coin.amountInDollar))")
                            .font(Fonts.bold.size(16))
                            .foregroundColor(Color(AppColors.white.rawValue))
                        
                        Text("\(String(format: "%.2f", coin.changePercentage))%")
                            .font(Fonts.regular.size(14))
                            .foregroundColor(coin.changePercentage >= 0 ? Color(AppColors.green.rawValue) : Color(AppColors.red.rawValue))
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
}

#Preview {
    PortfolioView()
}
