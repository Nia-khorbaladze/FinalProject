//
//  AmountChangeView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import SwiftUI

struct AmountChangeView: View {
    let amountChange: String?
    
    var body: some View {
        Text(amountChange ?? "+0.00%")
            .font(Fonts.semiBold.size(20))
            .foregroundColor(getTextColor())
    }
    
    private func getTextColor() -> Color {
        if amountChange == nil {
            return Color(AppColors.lightGrey.rawValue)
        } else if let amount = amountChange, amount.starts(with: "+") {
            return Color(AppColors.green.rawValue)
        } else {
            return Color(AppColors.red.rawValue)
        }
    }
}
