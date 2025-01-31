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
    private let coreDataService: CoreDataServiceProtocol
    private let cacheTimeout: TimeInterval = 300

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }

    func saveFavorite(userID: String, coinName: String) async throws {
        let favoriteRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
            .document(coinName)
        
        try await favoriteRef.setData([
            "name": coinName
        ])
        
        let key = "favoriteCoins"
        coreDataService.deleteCache(forKey: key)
        
        let updatedFavorites = try await fetchFavorites(userID: userID, fetchFromFirebase: true)
        coreDataService.saveResponse(updatedFavorites, forKey: key)
    }

    func removeFavorite(userID: String, coinName: String) async throws {
        let favoriteRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
            .document(coinName)
        
        try await favoriteRef.delete()
        
        let key = "favoriteCoins"
        coreDataService.deleteCache(forKey: key)
        
        let updatedFavorites = try await fetchFavorites(userID: userID, fetchFromFirebase: true)
        coreDataService.saveResponse(updatedFavorites, forKey: key)
    }

    func isFavorite(userID: String, coinName: String) async throws -> Bool {
        let key = "favoriteCoins"
        let (cachedFavorites, _) = coreDataService.fetchResponse(forKey: key, as: [String].self)

        if let cachedFavorites = cachedFavorites {
            let isFavorite = cachedFavorites.contains(coinName)
            return isFavorite
        }
        
        let favoriteRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
            .document(coinName)
        
        let snapshot = try await favoriteRef.getDocument()
        return snapshot.exists
    }
    
    func fetchFavorites(userID: String, fetchFromFirebase: Bool = false) async throws -> [String] {
        let key = "favoriteCoins"
        coreDataService.cleanupExpiredCache(forKey: key, expiration: cacheTimeout)

        if !fetchFromFirebase {
            let (cachedFavorites, _) = coreDataService.fetchResponse(forKey: key, as: [String].self)
            
            if let cachedFavorites = cachedFavorites {
                return cachedFavorites
            }
        }
                
        let favoritesRef = db.collection("Users")
            .document(userID)
            .collection("favoriteCoins")
        
        let snapshot = try await favoritesRef.getDocuments()
        let favorites = snapshot.documents.compactMap { $0.documentID }
        coreDataService.saveResponse(favorites, forKey: key)
        
        return favorites
    }
}
