//
//  HomePageContentView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 22.01.25.
//

import SwiftUI

struct HomePageContentView: View {
    @StateObject var viewModel: HomePageViewModel
    var onReceiveTapped: (() -> Void)?
    var onSendTapped: (() -> Void)?
    var onSwapTapped: (() -> Void)?
    var onBuyTapped: (() -> Void)?
    var onCoinTapped: (CoinResponse) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HomePageTopSectionView(
                    viewModel: viewModel,
                    onReceiveTapped: onReceiveTapped,
                    onSendTapped: onSendTapped,
                    onSwapTapped: onSwapTapped,
                    onBuyTapped: onBuyTapped
                )
                .padding(.top, 20)

                CoinsListView(
                    viewModel: viewModel,
                    title: "Trending",
                    showTitle: true,
                    onCoinTapped: onCoinTapped
                )
            }
            .padding(.horizontal)
            .frame(minHeight: UIScreen.main.bounds.height - 100)
        }
        .background(Color(AppColors.backgroundColor.rawValue).edgesIgnoringSafeArea(.all))
    }
}

