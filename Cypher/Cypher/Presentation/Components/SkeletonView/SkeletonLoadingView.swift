//
//  SkeletonLoadingView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import SwiftUI

struct SkeletonLoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            ForEach(0..<5) { _ in
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 16)
                        
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 80, height: 14)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 16)
    }
}

