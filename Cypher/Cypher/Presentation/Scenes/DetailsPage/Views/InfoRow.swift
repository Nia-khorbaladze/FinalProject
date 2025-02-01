//
//  InfoRow.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import SwiftUI

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

