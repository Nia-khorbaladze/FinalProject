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
    private let coreDataService: CoreDataServiceProtocol
    private let cacheTimeout: TimeInterval = 300
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    
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
        
        let key = "purchasedCoins"
        coreDataService.deleteCache(forKey: key)
        
        let updatedPurchasedCoins = try await fetchPurchasedCoins(userID: userID, fetchFromFirebase: true)
        coreDataService.saveResponse(updatedPurchasedCoins, forKey: key)
    }
    
    func fetchPurchasedCoins(userID: String, fetchFromFirebase: Bool = false) async throws -> [PurchasedCoin] {
        let key = "purchasedCoins"
        
        coreDataService.cleanupExpiredCache(forKey: key, expiration: cacheTimeout)

        if !fetchFromFirebase {
            let (cachedPurchasedCoins, _) = coreDataService.fetchResponse(forKey: key, as: [PurchasedCoin].self)
            
            if let cachedPurchasedCoins = cachedPurchasedCoins {
                return cachedPurchasedCoins
            }
        }
        
        let coinRef = db.collection("Users")
            .document(userID)
            .collection("purchasedCoins")
        
        let snapshot = try await coinRef.getDocuments()
        
        let purchasedCoins = snapshot.documents.compactMap { document -> PurchasedCoin? in
            guard
                let name = document.data()["name"] as? String,
                let totalAmount = document.data()["totalAmount"] as? Double
            else {
                return nil
            }
            
            let imageURL = document.data()["imageURL"] as? String
            return PurchasedCoin(symbol: document.documentID, name: name, totalAmount: totalAmount, imageURL: imageURL)
        }
        
        coreDataService.saveResponse(purchasedCoins, forKey: key)
        return purchasedCoins
    }
}
