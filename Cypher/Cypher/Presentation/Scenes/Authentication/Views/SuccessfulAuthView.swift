//
//  SuccessfulAuthView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 13.01.25.
//

import SwiftUI

struct SuccessfulAuthView: View {
    let successMessageTitle: String
    let successMessageSubTitle: String
    
    var body: some View {
        ZStack {
            Color(AppColors.backgroundColor.rawValue)
                .ignoresSafeArea(edges: .all)
            
            VStack(spacing: 5) {
                Image(Icons.successfulAuth.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 340, height: 340)
                    .padding(.trailing, 30)
                
                Text(successMessageTitle)
                    .font(Fonts.semiBold.size(30))
                    .foregroundStyle(Color(AppColors.white.rawValue))
        
                Text(successMessageSubTitle)
                    .font(Fonts.regular.size(15))
                    .foregroundStyle(Color(AppColors.lightGrey.rawValue))
            }
        }
    }
}
