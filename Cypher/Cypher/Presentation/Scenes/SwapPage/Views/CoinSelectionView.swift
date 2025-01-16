//
//  CoinSelectionView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct CoinSelectionView: View {
    let coins: [Coin]
    @Binding var selectedCoin: Coin
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(AppColors.backgroundColor.rawValue).edgesIgnoringSafeArea(.all)
                trendingCoinsView(for: coins) { coin in
                    selectedCoin = coin
                    isPresented = false
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
        }
    }
}
