//
//  DetailsPageView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import SwiftUI

struct DetailsPageView: View {
    @State private var isFavorited: Bool = false
    var onBack: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button(action: { onBack?() }) {
                    Image(systemName: "chevron.backward")
                        .font(Fonts.regular.size(18))
                        .foregroundColor(Color(AppColors.white.rawValue))
                }
                Spacer()
                Text("Bitcoin")
                    .font(Fonts.medium.size(18))
                    .foregroundColor(Color(AppColors.white.rawValue))
                Spacer()
                Button(action: {
                    isFavorited.toggle()
                }) {
                    Image(systemName: isFavorited ? "heart.fill" : "heart")
                        .font(Fonts.regular.size(18))
                        .foregroundColor(Color(AppColors.lightGrey.rawValue))
                }
            }
            .padding()
            .background(Color(AppColors.greyBlue.rawValue))
            .ignoresSafeArea(edges: .top)
            
            ScrollView {
                VStack(spacing: 5) {
                    Text("$0.00")
                        .font(Fonts.bold.size(48))
                        .foregroundStyle(Color(AppColors.white.rawValue))
                        .padding(.top, 20)
                    
                    HStack(spacing: 8) {
                        AmountChangeView(amountChange: nil)
                        
                        PercentageChangeView(percentageChange: nil)
                    }
                    
                    ChartView()
                    CoinInfoView()
                }
            }
            .background(Color(AppColors.backgroundColor.rawValue))
        }
    }
}

