//
//  PrimaryButton.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            if isActive { action() }
        }) {
            Text(title)
                .font(Fonts.bold.size(15))
                .frame(width: 360, height: 50)
                .background(isActive ? Color(AppColors.accent.rawValue) : Color(AppColors.inactiveAccent.rawValue))
                .foregroundColor(Color(AppColors.backgroundColor.rawValue))
                .cornerRadius(25)
                .animation(.easeInOut, value: isActive)
        }
        .disabled(!isActive)
    }
}
