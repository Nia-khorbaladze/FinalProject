//
//  IsFavoriteCoinUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

final class IsFavoriteCoinUseCase: IsFavoriteCoinUseCaseProtocol {
    private let repository: FavoriteCoinsRepositoryProtocol

    init(repository: FavoriteCoinsRepositoryProtocol) {
        self.repository = repository
    }

    func execute(userID: String, coinName: String) async throws -> Bool {
        return try await repository.isFavorite(userID: userID, coinName: coinName)
    }
}
