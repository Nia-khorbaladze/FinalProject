//
//  HomePageTopSectionView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import SwiftUI

struct HomePageTopSectionView: View {
    @ObservedObject var viewModel: HomePageViewModel
    var onReceiveTapped: (() -> Void)?
    var onSendTapped: (() -> Void)?
    var onSwapTapped: (() -> Void)?
    var onBuyTapped: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 5) {
            Text("$\(viewModel.totalPortfolioValue, specifier: "%.2f")")
                .font(Fonts.bold.size(48))
                .foregroundStyle(Color(AppColors.white.rawValue))

            HStack(spacing: 8) {
                AmountChangeView(amountChange: viewModel.totalPriceChange)
                
                PercentageChangeView(percentageChange: viewModel.totalPercentageChange)
            }
            
            HStack {
                ActionButton(iconName: Icons.scan.rawValue, title: "Receive", width: 90) {
                    onReceiveTapped?()
                }
                
                ActionButton(iconName: Icons.send.rawValue, title: "Send", width: 90) {
                    onSendTapped?()
                }
                
                ActionButton(iconName: Icons.swap.rawValue, title: "Swap", width: 90) {
                    onSwapTapped?()
                }
                
                ActionButton(iconName: Icons.buy.rawValue, title: "Buy", width: 90) {
                    onBuyTapped?()
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 40)
        }
        .onAppear {
            viewModel.fetchPortfolio()
        }
        .background(Color.clear)
    }
}
