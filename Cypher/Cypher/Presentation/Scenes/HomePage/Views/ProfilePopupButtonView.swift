//
//  ProfilePopupView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import SwiftUI

struct ProfilePopupButtonView: View {
    let action: () -> Void
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack {
                Circle()
                    .fill(Color(AppColors.accent.rawValue))
                    .frame(width: 40, height: 40)
            }
            
            Button(action: action) {
                HStack {
                    Text("User")
                        .font(Fonts.semiBold.size(17))
                        .foregroundColor(Color(AppColors.white.rawValue))
                    
                    Image(systemName: "chevron.down")
                        .frame(width: 15, height: 15)
                        .foregroundStyle(Color(AppColors.white.rawValue))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 15)
        .background(Color.clear)
    }
}


#Preview {
    ProfilePopupButtonView(action: { print("Abc") })
}
