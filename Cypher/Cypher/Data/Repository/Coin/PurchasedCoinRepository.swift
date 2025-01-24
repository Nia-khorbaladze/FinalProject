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
    
    func savePurchase(userID: String, coinSymbol: String, coinName: String, purchase: Purchase) async throws {
        let coinData: [String: Any] = [
            "name": coinName
        ]
        
        let purchaseData: [String: Any] = [
            "amount": purchase.amount,
            "timestamp": Timestamp(date: purchase.timestamp)
        ]
        
        let coinRef = db.collection("Users")
            .document(userID)
            .collection("purchasedCoins")
            .document(coinSymbol)
        try await coinRef.setData(coinData)
        
        try await coinRef.collection("purchases").addDocument(data: purchaseData)
    }
}
