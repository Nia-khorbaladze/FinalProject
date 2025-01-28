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
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(AppColors.backgroundColor.rawValue).edgesIgnoringSafeArea(.all)
                
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
                        } else {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                ForEach(viewModel.coins, id: \.id) { coin in
                                    TrendingCoinRow(coin: coin) { selectedCoin in
                                        self.selectedCoin = selectedCoin
                                        isPresented = false
                                    }
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchCoins()
                    viewModel.fetchPurchasedCoins()
                }
            }
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
            .toolbarBackground(Color(AppColors.backgroundColor.rawValue), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

