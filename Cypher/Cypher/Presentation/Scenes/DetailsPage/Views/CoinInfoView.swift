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
                InfoRow(label: "Market Cap", value: InfoRow.formatCurrency(coinDetail.marketCap), showDivider: true)
                InfoRow(label: "Total Supply", value: InfoRow.formatLargeNumber(coinDetail.totalSupply ?? 0), showDivider: true)
                InfoRow(label: "Circulating Supply", value: InfoRow.formatLargeNumber(coinDetail.circulatingSupply ?? 0), showDivider: true)
                InfoRow(label: "Max Supply", value: InfoRow.formatLargeNumber(coinDetail.maxSupply ?? 0), showDivider: false)
            }
            .padding()
            .background(Color(AppColors.greyBlue.rawValue))
            .cornerRadius(12)
        }
        .padding()
        .background(Color(AppColors.backgroundColor.rawValue).edgesIgnoringSafeArea(.all))
    }
}
