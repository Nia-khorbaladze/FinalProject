//
//  RemoveFavoriteCoinUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

final class RemoveFavoriteCoinUseCase {
    private let repository: FavoriteCoinsRepository

    init(repository: FavoriteCoinsRepository) {
        self.repository = repository
    }

    func execute(userID: String, coinName: String) async throws {
        try await repository.removeFavorite(userID: userID, coinName: coinName)
    }
}
