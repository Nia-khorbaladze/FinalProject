//
//  SelectCoinViewHeader.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import SwiftUI

struct SelectCoinViewHeader: View {
    let action: () -> Void
    @Binding var searchText: String

    var body: some View {
        ZStack {
            Color(AppColors.darkGrey.rawValue)
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                HStack {
                    Button(action: action) {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundColor(Color(AppColors.white.rawValue))
                            .padding(.leading, 3)
                    }
                    Spacer()
                    
                    Text("Buy")
                        .font(Fonts.medium.size(18))
                        .foregroundColor(Color(AppColors.white.rawValue))
                    
                    Spacer()
                    
                    Spacer()
                        .frame(width: 16)
                }
                .padding(.horizontal)
                .frame(height: 44)
                
                SearchBar(searchText: $searchText)
                    .padding(.bottom, 10)
            }
        }
        .frame(height: 120)
    }
}
