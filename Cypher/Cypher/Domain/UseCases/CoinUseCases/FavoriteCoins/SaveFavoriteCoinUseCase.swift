//
//  SaveFavoriteCoinUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

final class SaveFavoriteCoinUseCase: SaveFavoriteCoinUseCaseProtocol {
    private let repository: FavoriteCoinsRepository

    init(repository: FavoriteCoinsRepository) {
        self.repository = repository
    }

    func execute(userID: String, coinName: String) async throws {
        try await repository.saveFavorite(userID: userID, coinName: coinName)
    }
}
