//
//  PurchasedCoinRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 22.01.25.
//

import Foundation
import FirebaseFirestore

final class PurchasedCoinRepository: PurchasedCoinRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func savePurchase(userID: String, coinSymbol: String, purchase: Purchase) async throws {
        let data: [String: Any] = [
            "amount": purchase.amount,
            "timestamp": Timestamp(date: purchase.timestamp)
        ]
        
        try await db.collection("Users")
            .document(userID)
            .collection("purchasedCoins")
            .document(coinSymbol)
            .collection("purchases")
            .addDocument(data: data)
    }
}
