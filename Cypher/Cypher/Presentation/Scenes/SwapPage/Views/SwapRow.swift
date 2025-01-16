//
//  SwapRow.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SwapRow: View {
    let label: String
    @Binding var selectedCoin: Coin
    @Binding var amount: String
    @Binding var showCoinList: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                    .font(Fonts.semiBold.size(13))
                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
                
                TextField("0", text: $amount)
                    .font(Fonts.semiBold.size(32))
                    .keyboardType(.decimalPad)
                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
            }
            Spacer()
            VStack {
                Button(action: {
                    showCoinList = true
                }) {
                    HStack {
                        Image(systemName: selectedCoin.icon)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text(selectedCoin.symbol)
                            .font(Fonts.semiBold.size(13))
                            .foregroundColor(Color(AppColors.white.rawValue))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(AppColors.darkGrey.rawValue))
                    .cornerRadius(20)
                }
                
                Text("\(selectedCoin.price) SOL")
                    .font(Fonts.semiBold.size(13))
                    .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                    .padding(.top, 5)
            }
        }
        .padding(.horizontal)
        .frame(height: 130)
        .background(Color(AppColors.greyBlue.rawValue))
        .cornerRadius(16)
        .clipped()
    }
}
