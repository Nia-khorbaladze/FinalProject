//
//  DetailsPageView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import SwiftUI

struct DetailsPageView: View {
    @ObservedObject var viewModel: DetailsPageViewModel
    var onBack: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { onBack?() }) {
                    Image(systemName: "chevron.backward")
                        .font(Fonts.regular.size(18))
                        .foregroundColor(Color(AppColors.white.rawValue))
                }
                Spacer()
                Text(viewModel.coinDetail?.name ?? "Loading...")
                    .font(Fonts.medium.size(18))
                    .foregroundColor(Color(AppColors.white.rawValue))
                Spacer()
                Button(action: { viewModel.toggleFavorite() }) {
                    Image(systemName: viewModel.isFavorited ? "heart.fill" : "heart")
                        .font(Fonts.regular.size(18))
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                }
            }
            .padding()
            .background(Color(AppColors.greyBlue.rawValue))
            .ignoresSafeArea(edges: .top)
            
            if viewModel.isLoading {
                Spacer()
                ProgressView()
                    .padding(.top, 20)
                Spacer()
            } else if let error = viewModel.error {
                Spacer()
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                Spacer()
            } else if let coinDetail = viewModel.coinDetail {
                ScrollView {
                    VStack(spacing: 5) {
                        Text("$\(coinDetail.currentPrice, specifier: "%.2f")")
                            .font(Fonts.bold.size(48))
                            .foregroundStyle(Color(AppColors.white.rawValue))
                            .padding(.top, 20)
                        
                        HStack(spacing: 8) {
                            AmountChangeView(amountChange: coinDetail.priceChange24h)
                            PercentageChangeView(percentageChange: coinDetail.priceChangePercentage24h)
                        }
                        
                        ChartView()
                        CoinInfoView(coinDetail: coinDetail)
                    }
                }
                .background(Color(AppColors.backgroundColor.rawValue))
            } else {
                ProgressView()
                    .padding(.top, 20)
            }
        }
    }
}

