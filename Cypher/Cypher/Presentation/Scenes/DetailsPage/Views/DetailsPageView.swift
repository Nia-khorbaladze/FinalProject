//
//  DetailsPageView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import SwiftUI

struct DetailsPageView: View {
    var body: some View {
        ZStack {
            Color(AppColors.backgroundColor.rawValue)
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 5) {
                Text("$0.00")
                    .font(Fonts.bold.size(48))
                    .foregroundStyle(Color(AppColors.white.rawValue))
                
                HStack(spacing: 8) {
                    AmountChangeView(amountChange: nil)
                    
                    PercentageChangeView(percentageChange: nil)
                }
            }
        }
    }
}

#Preview {
    DetailsPageView()
}
