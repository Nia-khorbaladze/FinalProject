//
//  SearchPageView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SearchPageView: View {
    @ObservedObject var viewModel: CoinViewModel
    @State private var searchText: String = ""
    let onCoinTapped: (CoinResponse) -> Void
    
    var filteredCoins: [CoinResponse] {
        FilterUtility.filterItems(
            viewModel.coins,
            searchText: searchText,
            keyPaths: [\CoinResponse.name, \CoinResponse.symbol]
        )
    }
    
    var body: some View {
        VStack {
            SearchBar(searchText: $searchText)
                .padding(.horizontal)
            
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else if filteredCoins.isEmpty {
                    Text("No coins found.")
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(filteredCoins, id: \.id) { coin in
                            TrendingCoinRow(coin: coin, onCoinTap: onCoinTapped)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .onAppear {
                viewModel.fetchCoins()
            }
        }
        .background(Color(AppColors.backgroundColor.rawValue))
        .edgesIgnoringSafeArea(.bottom)
    }
}
