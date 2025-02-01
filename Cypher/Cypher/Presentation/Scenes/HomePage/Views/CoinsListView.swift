//
//  TrendingCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import SwiftUI

struct CoinsListView: View {
    @ObservedObject var viewModel: HomePageViewModel
    let title: String?
    let showTitle: Bool
    let onCoinTapped: (CoinResponse) -> Void

    var body: some View {
        ZStack {
            Color.clear

            if viewModel.isLoading {
                LazyVStack(alignment: .leading, spacing: 0) {
                    if showTitle, let title = title {
                        Text(title)
                            .font(Fonts.bold.size(20))
                            .foregroundStyle(Color(AppColors.white.rawValue))
                            .padding(.horizontal)
                            .padding(.top)
                    }
                    
                    ForEach(0..<5, id: \.self) { _ in
                        SkeletonLoadingView()
                    }
                }
                .frame(maxWidth: .infinity)
                .transition(.opacity)
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                LazyVStack(alignment: .leading, spacing: 0) {
                    if showTitle, let title = title {
                        Text(title)
                            .font(Fonts.bold.size(20))
                            .foregroundStyle(Color(AppColors.white.rawValue))
                            .padding(.horizontal)
                            .padding(.top)
                    }

                    ForEach(viewModel.coins, id: \.id) { coin in
                        CoinRowView(coin: coin, onCoinTapped: onCoinTapped)
                    }
                }
                .frame(maxWidth: .infinity)
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.isLoading)
        .onAppear {
            viewModel.fetchCoins()
        }
    }
}
