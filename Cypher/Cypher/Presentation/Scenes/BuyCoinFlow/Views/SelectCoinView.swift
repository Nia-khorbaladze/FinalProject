//
//  SelectCoinView.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import SwiftUI

struct SelectCoinView: View {
    @State private var searchText = ""
    @ObservedObject var viewModel: CoinViewModel
    let onCoinTap: (CoinResponse) -> Void
    let onCloseTap: () -> Void

    var body: some View {
        VStack {
            SelectCoinViewHeader(
                action: { onCloseTap() },
                searchText: $searchText
            )
            SearchableCoinsListView(
                viewModel: viewModel,
                searchText: $searchText,
                onCoinTapped: onCoinTap
            )
        }
        .background(Color(AppColors.backgroundColor.rawValue))
        .edgesIgnoringSafeArea(.bottom)
    }
}


