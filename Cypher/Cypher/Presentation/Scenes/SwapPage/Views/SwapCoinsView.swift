//
//  SwapCoinsView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI

struct SwapCoinsView: View {
    @ObservedObject var viewModel: SwapViewModel

    @State private var selectedPayCoin: Coin = Coin(name: "Solana", symbol: "SOL", price: 0.0, changePercentage: 0.0, icon: "s.circle")
    @State private var selectedReceiveCoin: Coin = Coin(name: "USDC", symbol: "USDC", price: 0.0, changePercentage: 0.0, icon: "circle.fill")
    @State private var showCoinListForPay = false
    @State private var showCoinListForReceive = false
    
    let coins = [
        Coin(name: "Bitcoin", symbol: "BTC", price: 70982.0, changePercentage: -0.39, icon: "bitcoinsign.circle"),
        Coin(name: "Ethereum", symbol: "ETH", price: 3463.27, changePercentage: 3.55, icon: "e.circle"),
        Coin(name: "BNB", symbol: "BNB", price: 707.69, changePercentage: -0.03, icon: "circle.fill"),
        Coin(name: "XRP", symbol: "XRP", price: 2.38, changePercentage: 9.70, icon: "x.circle"),
        Coin(name: "Solana", symbol: "SOL", price: 206.61, changePercentage: 8.48, icon: "s.circle"),
        Coin(name: "USDC", symbol: "USDC", price: 1.0, changePercentage: 0.0, icon: "dollarsign.circle")
    ]
    
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
                .onTapGesture {
                    showCoinListForPay = true
                }
                
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
                    amount: .constant("0"),
                    showCoinList: $showCoinListForReceive
                )
                .onTapGesture {
                    showCoinListForReceive = true
                }
            }
            .padding()
            .background(Color(AppColors.backgroundColor.rawValue))
            .cornerRadius(16)
            
            Spacer()
        }
        .sheet(isPresented: $showCoinListForPay) {
            CoinSelectionView(
                coins: coins,
                selectedCoin: $selectedPayCoin,
                isPresented: $showCoinListForPay
            )
        }
        .sheet(isPresented: $showCoinListForReceive) {
            CoinSelectionView(
                coins: coins,
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
        viewModel.payAmount = "0"
    }
}
