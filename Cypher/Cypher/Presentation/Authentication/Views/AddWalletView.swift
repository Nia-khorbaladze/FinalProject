//
//  AddWalletView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import SwiftUI

struct AddWalletView: View {
    var body: some View {
        ZStack {
            Color(AppColors.backgroundColor.rawValue)
                .ignoresSafeArea(edges: .all)
            
            VStack() {
                Image(Icons.wallet.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 185, height: 185)
                    .padding(.bottom, 20)
                VStack(spacing: 8) {
                    Text("Add A Wallet")
                        .font(Fonts.bold.size(28))
                        .foregroundStyle(Color(AppColors.white.rawValue))
                    
                    Text("Login or import an existing wallet")
                        .font(Fonts.regular.size(14))
                        .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                        .padding(.bottom, 20)
                }

                VStack(alignment: .leading, spacing: 30) {
                    descriptionRow(
                        image: Image(Icons.wand.rawValue),
                        title: "Seamless setup",
                        subtext: "Create a wallet using a Google or Apple account"
                    )
                    descriptionRow(
                        image: Image(Icons.shield.rawValue),
                        title: "Enhanced security",
                        subtext: "Your wallet is stored securely and decentralized across multiple factors"
                    )
                    descriptionRow(
                        image: Image(Icons.recovery.rawValue),
                        title: "Easy recovery",
                        subtext: "Recover access to your wallet with your Google account and a 4-digit PIN"
                    )
                }
                .padding(.trailing, 20)
            }
            .padding(.bottom, 40)
            .padding(.horizontal, 24)
        }
    }
    
    // MARK: - Description element
    private func descriptionRow(image: Image, title: String, subtext: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            image
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(Fonts.bold.size(15))
                    .foregroundStyle(Color(AppColors.white.rawValue))
                
                Text(subtext)
                    .font(Fonts.regular.size(14))
                    .foregroundStyle(Color(AppColors.lightGrey.rawValue))
                    .lineLimit(nil)
            }
        }
    }
}

#Preview {
    AddWalletView()
}
