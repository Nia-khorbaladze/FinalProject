//
//  ActionButton.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import SwiftUI

struct ActionButton: View {
    let iconName: String
    let title: String
    let width: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 32, maxHeight: 35)
                Text(title)
                    .font(.footnote)
                    .foregroundColor(Color(AppColors.lightGrey.rawValue))
            }
            .frame(height: 80)
            .frame(maxWidth: width)
            .background(Color(AppColors.greyBlue.rawValue))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

