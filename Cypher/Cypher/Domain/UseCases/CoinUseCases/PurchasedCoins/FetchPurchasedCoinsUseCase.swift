//
//  FetchPurchasedCoinsUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

final class FetchPurchasedCoinsUseCase {
    private let purchasedCoinRepository: PurchasedCoinRepositoryProtocol

    init(purchasedCoinRepository: PurchasedCoinRepositoryProtocol) {
        self.purchasedCoinRepository = purchasedCoinRepository
    }

    func execute(userID: String) async throws -> [PurchasedCoin] {
        return try await purchasedCoinRepository.fetchPurchasedCoins(userID: userID)
    }
}

