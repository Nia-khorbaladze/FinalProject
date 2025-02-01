//
//  DetailsSkeletonLoadingView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import SwiftUI

struct DetailsSkeletonLoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            SkeletonRowView(width: 200, height: 24)
                .padding(.top, 20)
            
            SkeletonRowView(width: 150, height: 48)
                .padding(.top, 10)
            
            SkeletonRowView(width: UIScreen.main.bounds.width - 32, height: 200)
                .padding(.top, 20)
            
            SkeletonRowView(width: UIScreen.main.bounds.width - 32, height: 40)
                .padding(.top, 16)
            SkeletonRowView(width: UIScreen.main.bounds.width - 32, height: 40)
        }
        .padding(.horizontal)
    }
}

struct SkeletonRowView: View {
    var width: CGFloat
    var height: CGFloat

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.gray.opacity(0.3))
            .frame(width: width, height: height)
    }
}
