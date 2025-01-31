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
    
    func savePurchase(userID: String, coinSymbol: String, coinName: String, purchase: Purchase, imageURL: String) async throws {
        let coinRef = db.collection("Users")
            .document(userID)
            .collection("purchasedCoins")
            .document(coinSymbol)
        
        _ = try await db.runTransaction { transaction, errorPointer in
            do {
                let coinSnapshot = try transaction.getDocument(coinRef)
                
                if coinSnapshot.exists {
                    if let currentAmount = coinSnapshot.data()?["totalAmount"] as? Double {
                        let updatedAmount = currentAmount + purchase.amount
                        
                        transaction.updateData([
                            "totalAmount": updatedAmount,
                            "lastUpdated": Timestamp(date: Date())
                        ], forDocument: coinRef)
                    }
                } else {
                    transaction.setData([
                        "name": coinName,
                        "totalAmount": purchase.amount,
                        "imageURL": imageURL,
                        "lastUpdated": Timestamp(date: Date())
                    ], forDocument: coinRef)
                }
            } catch let error {
                errorPointer?.pointee = error as NSError
            }
            return nil
        }
    }
    
    func fetchPurchasedCoins(userID: String) async throws -> [PurchasedCoin] {
        let coinRef = db.collection("Users")
            .document(userID)
            .collection("purchasedCoins")
        
        let snapshot = try await coinRef.getDocuments()
        
        return snapshot.documents.compactMap { document in
            guard
                let name = document.data()["name"] as? String,
                let totalAmount = document.data()["totalAmount"] as? Double
            else {
                return nil
            }
            
            let imageURL = document.data()["imageURL"] as? String 
            
            return PurchasedCoin(symbol: document.documentID, name: name, totalAmount: totalAmount, imageURL: imageURL)
        }
    }
}
