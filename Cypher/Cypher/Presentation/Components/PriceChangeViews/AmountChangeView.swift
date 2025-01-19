//
//  AmountChangeView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import SwiftUI

struct AmountChangeView: View {
    let amountChange: Double?
    
    var body: some View {
        Text(formatAmount())
            .font(Fonts.semiBold.size(20))
            .foregroundColor(getTextColor())
    }
    
    private func formatAmount() -> String {
        guard let value = amountChange else { return "0.00$" }
        let formattedValue = String(format: "%.2f", value)
        return value < 0 ? formattedValue + "$" : "+" + formattedValue + "$"
    }
    
    private func getTextColor() -> Color {
        if amountChange == nil {
            return Color(AppColors.lightGrey.rawValue)
        } else if let amount = amountChange, amount < 0 {
            return Color(AppColors.red.rawValue)
        } else {
            return Color(AppColors.green.rawValue)
        }
    }
}
