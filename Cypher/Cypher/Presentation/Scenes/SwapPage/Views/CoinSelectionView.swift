//
//  CoinSelectionView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct CoinSelectionView: View {
    @ObservedObject var viewModel: SwapViewModel
    @Binding var selectedCoin: CoinResponse?
    @Binding var isPresented: Bool
    @State private var searchText: String = ""

    var filteredCoins: [CoinResponse] {
        FilterUtility.filterItems(
            viewModel.coins,
            searchText: searchText,
            keyPaths: [\CoinResponse.name, \CoinResponse.symbol]
        )
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                    .padding(.horizontal)
                    .padding(.top)

                ScrollView {
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical)
                    } else if let error = viewModel.error {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else if filteredCoins.isEmpty {
                        Text("No coins found.")
                            .foregroundColor(Color(AppColors.lightGrey.rawValue))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical)
                    } else {
                        LazyVStack(alignment: .leading, spacing: 0) {
                            ForEach(filteredCoins, id: \.id) { coin in
                                TrendingCoinRow(coin: coin) { selectedCoin in
                                    self.selectedCoin = selectedCoin
                                    isPresented = false
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .onAppear {
                    if viewModel.coins.isEmpty {
                        viewModel.fetchCoins()
                    }
                }
            }
            .background(Color(AppColors.backgroundColor.rawValue))
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.headline)
                            .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                    }
                }
            }
        }
    }
}


