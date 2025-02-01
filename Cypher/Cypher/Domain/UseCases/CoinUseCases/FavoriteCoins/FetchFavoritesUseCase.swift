//
//  FetchFavoritesUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

final class FetchFavoritesUseCase: FetchFavoritesUseCaseProtocol {
    private let repository: FavoriteCoinsRepositoryProtocol
    
    init(repository: FavoriteCoinsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(userID: String) async throws -> [String] {
        try await repository.fetchFavorites(userID: userID, fetchFromFirebase: false)
    }
}
