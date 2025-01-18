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
    
    static func formatLargeNumber(_ number: Double) -> String {
        let billion = 1_000_000_000.0
        let million = 1_000_000.0
        let thousand = 1_000.0
        
        switch number {
        case ..<thousand:
            return String(format: "%.2f", number)
        case ..<million:
            return String(format: "%.2fK", number / thousand)
        case ..<billion:
            return String(format: "%.2fM", number / million)
        default:
            return String(format: "%.2fB", number / billion)
        }
    }
    
    static func formatCurrency(_ number: Double) -> String {
        let trillion = 1_000_000_000_000.0
        let billion = 1_000_000_000.0
        let million = 1_000_000.0
        
        switch number {
        case ..<million:
            return "$" + String(format: "%.2f", number)
        case ..<billion:
            return "$" + String(format: "%.2fM", number / million)
        case ..<trillion:
            return "$" + String(format: "%.2fB", number / billion)
        default:
            return "$" + String(format: "%.2fT", number / trillion)
        }
    }
}
