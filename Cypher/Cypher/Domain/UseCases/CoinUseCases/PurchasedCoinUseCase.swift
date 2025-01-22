//
//  SavePurchasedCoinUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 22.01.25.
//

import Foundation

final class PurchasedCoinUseCase {
    private let repository: PurchasedCoinRepositoryProtocol
    
    init(repository: PurchasedCoinRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(userID: String, coinSymbol: String, amount: Double) async throws {
        let purchase = Purchase(amount: amount, timestamp: Date())
        try await repository.savePurchase(userID: userID, coinSymbol: coinSymbol, purchase: purchase)
    }
}
