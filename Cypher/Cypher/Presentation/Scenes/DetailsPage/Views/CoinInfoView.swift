//
//  CoinInfoView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import SwiftUI

struct CoinInfoView: View {
    let coinDetail: CoinDetailModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Info")
                .font(Fonts.semiBold.size(18))
                .foregroundColor(Color(AppColors.lightGrey.rawValue))
                .padding(.bottom, 8)
            
            VStack(spacing: 8) {
                InfoRow(label: "Symbol", value: coinDetail.symbol, showDivider: true)
                InfoRow(label: "Name", value: coinDetail.name, showDivider: true)
                InfoRow(label: "Market Cap", value: String(format: "$%.2f", coinDetail.marketCap), showDivider: true)
                InfoRow(label: "Total Supply", value: String(format: "%.2f", coinDetail.totalSupply ?? 0), showDivider: true)
                InfoRow(label: "Circulating Supply", value: String(format: "%.2f", coinDetail.circulatingSupply ?? 0), showDivider: true)
                InfoRow(label: "Max Supply", value: String(format: "%.2f", coinDetail.maxSupply ?? 0), showDivider: false)
            }
            .padding()
            .background(Color(AppColors.greyBlue.rawValue))
            .cornerRadius(12)
        }
        .padding()
        .background(Color(AppColors.backgroundColor.rawValue).edgesIgnoringSafeArea(.all))
    }
}


struct InfoRow: View {
    let label: String
    let value: String
    let showDivider: Bool
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(Color(AppColors.lightGrey.rawValue))
                .font(Fonts.medium.size(18))
            
            Spacer()
            
            Text(value)
                .foregroundColor(Color(AppColors.white.rawValue))
                .font(Fonts.medium.size(18))
        }
        .padding(.vertical, 8)
        if showDivider {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(AppColors.backgroundColor.rawValue))
                .padding(.horizontal, -16)
        }
    }
}
