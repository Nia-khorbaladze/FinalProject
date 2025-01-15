//
//  PercentageChangeView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import SwiftUI

struct PercentageChangeView: View {
    let percentageChange: String?

    var body: some View {
        Text(percentageChange ?? "+0.00%")
            .font(Fonts.semiBold.size(20))
            .foregroundColor(getTextColor())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(getBackgroundColor())
            )
    }

    private func getTextColor() -> Color {
        if percentageChange == nil {
            return Color(AppColors.lightGrey.rawValue)
        } else {
            return Color(AppColors.backgroundColor.rawValue)
        }
    }

    private func getBackgroundColor() -> Color {
        if percentageChange == nil {
            return Color.gray.opacity(0.2)
        } else if let percentage = percentageChange, percentage.starts(with: "+") {
            return Color(AppColors.green.rawValue)
        } else {
            return Color(AppColors.red.rawValue)
        }
    }
}
