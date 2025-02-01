//
//  RemoveFavoriteCoinUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

final class RemoveFavoriteCoinUseCase: RemoveFavoriteCoinUseCaseProtocol {
    private let repository: FavoriteCoinsRepositoryProtocol

    init(repository: FavoriteCoinsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(userID: String, coinName: String) async throws {
        try await repository.removeFavorite(userID: userID, coinName: coinName)
    }
}
