//
//  SavePurchasedCoinUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 24.01.25.
//

import Foundation

final class SavePurchasedCoinUseCase {
    private let purchasedCoinRepository: PurchasedCoinRepositoryProtocol

    init(purchasedCoinRepository: PurchasedCoinRepositoryProtocol) {
        self.purchasedCoinRepository = purchasedCoinRepository
    }

    func execute(userID: String, coinSymbol: String, coinName: String, amount: Double) async throws {
        let purchase = Purchase(amount: amount, timestamp: Date())
        try await purchasedCoinRepository.savePurchase(userID: userID, coinSymbol: coinSymbol, coinName: coinName, purchase: purchase)
    }
}
