//
//  FavoriteCoinsRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation
import FirebaseFirestore

final class FavoriteCoinsRepository: FavoriteCoinsRepositoryProtocol {
    private let db = Firestore.firestore()

    func saveFavorite(userID: String, coinName: String) async throws {
        let favoriteRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
            .document(coinName)
        
        try await favoriteRef.setData([
            "name": coinName
        ])
    }

    func removeFavorite(userID: String, coinName: String) async throws {
        let favoriteRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
            .document(coinName)
        
        try await favoriteRef.delete()
    }

    func isFavorite(userID: String, coinName: String) async throws -> Bool {
        let favoriteRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
            .document(coinName)
        
        let snapshot = try await favoriteRef.getDocument()
        return snapshot.exists
    }
    
    func fetchFavorites(userID: String) async throws -> [String] {
        let favoritesRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
        
        let snapshot = try await favoritesRef.getDocuments()
        return snapshot.documents.compactMap { $0.documentID }
    }
}

