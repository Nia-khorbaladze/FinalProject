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
        ScrollView {
            ZStack {
                Color.clear
                    .frame(maxWidth: .infinity, minHeight: 400)
                
                if viewModel.isLoading {
                    ProgressView()
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if filteredCoins.isEmpty {
                    Text("No coins found.")
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                } else {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filteredCoins, id: \.id) { coin in
                            CoinRowView(coin: coin, onCoinTapped: onCoinTapped)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchCoins()
        }
    }
}
