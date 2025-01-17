//
//  FetchCoinsUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class FetchCoinsUseCase {
    private let repository: CoinRepositoryProtocol

    init(repository: CoinRepositoryProtocol) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[CoinResponse], NetworkError> {
        return repository.fetchCoins()
    }
}
