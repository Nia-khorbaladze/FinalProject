//
//  FavoriteCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 27.01.25.
//

import SwiftUI

struct FavoriteCoinsView: View {
    @StateObject private var viewModel: FavoritesViewModel
    
    init(viewModel: FavoritesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Favorites")
                        .font(Fonts.bold.size(24))
                        .foregroundStyle(Color(AppColors.white.rawValue))
                    Spacer()
                }
                .padding(.horizontal)

                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.favoriteCoins.isEmpty {
                    EmptyFavoritesView()
                } else {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(viewModel.favoriteCoins, id: \.id) { coin in
                            FavoriteCoinRowView(coin: coin)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
        }
        .onAppear {
            viewModel.fetchFavorites()
        }
    }
}
