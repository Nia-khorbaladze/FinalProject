//
//  SuccessfulUsernameChangeView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import SwiftUI

struct SuccessfulUsernameChangeView: View {
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
                
                Text("Done!")
                    .font(Fonts.semiBold.size(30))
                    .foregroundStyle(Color(AppColors.white.rawValue))
                Text("Username saved successfully")
                
                    .font(Fonts.regular.size(15))
                    .foregroundStyle(Color(AppColors.lightGrey.rawValue))
            }
        }
    }
}

