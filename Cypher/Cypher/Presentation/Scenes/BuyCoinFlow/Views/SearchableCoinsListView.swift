//
//  SearchableCoinsListView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import SwiftUI

struct SearchableCoinsListView: View {
    @ObservedObject var viewModel: CoinViewModel
    @Binding var searchText: String
    let onCoinTapped: (CoinResponse) -> Void
    
    var filteredCoins: [CoinResponse] {
        FilterUtility.filterItems(
            viewModel.coins,
            searchText: searchText,
            keyPaths: [\CoinResponse.name, \CoinResponse.symbol]
        )
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 400)
            } else if let error = viewModel.error {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
                    .frame(maxWidth: .infinity, minHeight: 400)
            } else if filteredCoins.isEmpty {
                Text("No coins found.")
                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
                    .frame(maxWidth: .infinity, minHeight: 400)
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filteredCoins, id: \.id) { coin in
                            CoinRowView(coin: coin, onCoinTapped: onCoinTapped)
                        }
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 400)
            }
        }
        .onAppear {
            viewModel.fetchCoins()
        }
    }
}
