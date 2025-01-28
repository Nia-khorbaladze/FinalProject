//
//  SwapRow.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SwapRow: View {
    let label: String
    @Binding var selectedCoin: CoinResponse?
    @Binding var amount: String
    @Binding var showCoinList: Bool
    var purchasedCoins: [PurchasedCoin]

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                    .font(Fonts.semiBold.size(13))
                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
                
                TextField(
                    "",
                    text: Binding(
                        get: {
                            amount
                        },
                        set: { newValue in
                            if newValue.isEmpty || Double(newValue) != nil {
                                amount = newValue
                            }
                        }
                    ),
                    prompt: Text("0")
                        .font(Fonts.semiBold.size(32))
                        .foregroundColor(Color(AppColors.lightGrey.rawValue).opacity(0.5))
                )
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
                        if let image = selectedCoin?.image {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                        } else {
                            Image(systemName: "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        Text(selectedCoin?.symbol ?? "Select")
                            .font(Fonts.semiBold.size(13))
                            .foregroundColor(Color(AppColors.white.rawValue))
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(AppColors.darkGrey.rawValue))
                    .cornerRadius(20)
                }
                
                if let selectedCoin = selectedCoin {
                    let ownedAmount = purchasedCoins.first { $0.symbol == selectedCoin.symbol.uppercased() }?.totalAmount ?? 0.0
                    Text("\(ownedAmount, specifier: "%.8f") \(selectedCoin.symbol.uppercased())")
                        .font(Fonts.semiBold.size(13))
                        .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                        .padding(.top, 5)
                } else {
                    Text("")
                        .font(Fonts.semiBold.size(13))
                        .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                        .padding(.top, 5)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 130)
        .background(Color(AppColors.greyBlue.rawValue))
        .cornerRadius(16)
        .clipped()
    }
}
