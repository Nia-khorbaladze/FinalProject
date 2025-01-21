//
//  HomePageTopSectionView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import SwiftUI

struct HomePageTopSectionView: View {
    var onReceiveTapped: (() -> Void)?
    var onSendTapped: (() -> Void)?
    var onSwapTapped: (() -> Void)?
    var onBuyTapped: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 5) {
            Text("$0.00")
                .font(Fonts.bold.size(48))
                .foregroundStyle(Color(AppColors.white.rawValue))
            
            HStack(spacing: 8) {
                AmountChangeView(amountChange: nil)
                
                PercentageChangeView(percentageChange: nil)
            }
            
            HStack {
                ActionButton(iconName: Icons.scan.rawValue, title: "Receive", width: 90) {
                    onReceiveTapped?()
                }
                
                ActionButton(iconName: Icons.send.rawValue, title: "Send", width: 90) {
                    onSendTapped?()
                }
                
                ActionButton(iconName: Icons.swap.rawValue, title: "Swap", width: 90) {
                    onSwapTapped?()
                }
                
                ActionButton(iconName: Icons.buy.rawValue, title: "Buy", width: 90) {
                    onBuyTapped?()
                }
            }
            .padding(.horizontal, 12)
            .padding(.top, 40)
        }
        .background(Color.clear)
    }
}
