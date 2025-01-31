//
//  SummaryViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 31.01.25.
//

import Foundation
import FirebaseAuth

final class SummaryViewModel {
    private let saveCoinsUseCase: SavePurchasedCoinUseCaseProtocol
    let amount: Double
    private let coinSymbol: String
    private let coinName: String
    private let imageURL: String
    
    init(saveCoinsUseCase: SavePurchasedCoinUseCaseProtocol, amount: Double, coinSymbol: String, coinName: String, imageURL: String) {
        self.saveCoinsUseCase = saveCoinsUseCase
        self.amount = amount
        self.coinSymbol = coinSymbol
        self.coinName = coinName
        self.imageURL = imageURL
    }
    
    func sendCoins() async throws {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid

        try await saveCoinsUseCase.execute(
            userID: userID,
            coinSymbol: coinSymbol,
            coinName: coinName,
            amount: -amount,
            imageURL: imageURL
        )
    }
}
