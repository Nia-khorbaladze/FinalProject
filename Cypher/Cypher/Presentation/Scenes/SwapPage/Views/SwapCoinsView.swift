//
//  SwapCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SwapCoinsView: View {
    @ObservedObject var viewModel: SwapViewModel

    @State private var selectedPayCoin: CoinResponse? = nil
    @State private var selectedReceiveCoin: CoinResponse? = nil
    @State private var showCoinListForPay = false
    @State private var showCoinListForReceive = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Swap Coins")
                .font(Fonts.bold.size(24))
                .foregroundColor(Color(AppColors.white.rawValue))
                .padding(.leading, 20)
            
            VStack(spacing: 16) {
                SwapRow(
                    label: "You Pay",
                    selectedCoin: $selectedPayCoin,
                    amount: $viewModel.payAmount,
                    showCoinList: $showCoinListForPay
                )
                
                Button(action: {
                    swapValues()
                }) {
                    Image(Icons.swap.rawValue)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .background(Color(AppColors.greyBlue.rawValue))
                        .clipShape(Circle())
                }
                
                SwapRow(
                    label: "You Receive",
                    selectedCoin: $selectedReceiveCoin,
                    amount: $viewModel.receiveAmount,
                    showCoinList: $showCoinListForReceive
                )
            }
            .padding()
            .background(Color(AppColors.backgroundColor.rawValue))
            .cornerRadius(16)
            
            Spacer()
        }
        .sheet(isPresented: $showCoinListForPay) {
            CoinSelectionView(
                viewModel: viewModel,
                selectedCoin: $selectedPayCoin,
                isPresented: $showCoinListForPay
            )
        }
        .sheet(isPresented: $showCoinListForReceive) {
            CoinSelectionView(
                viewModel: viewModel,
                selectedCoin: $selectedReceiveCoin,
                isPresented: $showCoinListForReceive
            )
        }
    }
    
    private func swapValues() {
        let tempCoin = selectedPayCoin
        selectedPayCoin = selectedReceiveCoin
        selectedReceiveCoin = tempCoin
        
        let tempAmount = viewModel.payAmount
        viewModel.payAmount = viewModel.receiveAmount
        viewModel.receiveAmount = tempAmount
    }
}

