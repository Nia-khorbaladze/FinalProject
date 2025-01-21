//
//  TrendingCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import SwiftUI

struct CoinsListView: View {
    @ObservedObject var viewModel: CoinViewModel
    let title: String?
    let showTitle: Bool
    let onCoinTapped: (CoinResponse) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if showTitle, let title = title {
                Text(title)
                    .font(Fonts.bold.size(20))
                    .foregroundStyle(Color(AppColors.white.rawValue))
                    .padding(.horizontal)
                    .padding(.top)
            }
            
            ZStack {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, minHeight: 400)
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 400)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(viewModel.coins, id: \.id) { coin in
                                CoinRowView(coin: coin, onCoinTapped: onCoinTapped)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 400)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
}

struct CoinRowView: View {
    let coin: CoinResponse
    let onCoinTapped: (CoinResponse) -> Void
    
    var body: some View {
        HStack {
            if let image = coin.image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.gray.opacity(0.3)))
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
                Text("\(coin.priceChangePercentage24h >= 0 ? "+" : "")\(String(format: "%.2f", coin.priceChangePercentage24h))%")
                    .font(Fonts.semiBold.size(18))
                    .foregroundColor(coin.priceChangePercentage24h >= 0 ? Color(AppColors.green.rawValue) : Color(AppColors.red.rawValue))
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
        .onTapGesture {
            onCoinTapped(coin)
        }
    }
}
