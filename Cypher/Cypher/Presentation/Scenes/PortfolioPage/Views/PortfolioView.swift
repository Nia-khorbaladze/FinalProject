//
//  PortfolioView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct PortfolioView: View {
    @StateObject private var viewModel: PortfolioViewModel
    
    init(viewModel: PortfolioViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Portfolio")
                        .font(Fonts.bold.size(24))
                        .foregroundStyle(Color(AppColors.white.rawValue))
                    Spacer()
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    SkeletonLoadingView()
                        .padding(.top, 16)
                } else if viewModel.portfolioCoins.isEmpty {
                    EmptyPortfolioView()
                } else {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.portfolioCoins, id: \.id) { coin in
                            PortfolioListRow(coin: coin)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
        }
        .onAppear {
            viewModel.fetchPortfolio()
        }
    }
}
