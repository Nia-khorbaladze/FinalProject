//
//  FetchCoinDetailUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class FetchCoinDetailUseCase {
    private let repository: CoinRepositoryProtocol

    init(repository: CoinRepositoryProtocol) {
        self.repository = repository
    }

    func execute(name: String) -> AnyPublisher<CoinDetailModel, NetworkError> {
        if let cachedCoin = repository.getCoinDetail(name: name) {
            return Just(cachedCoin)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        } else {
            return repository.fetchCoinDetail(name: name) 
                .handleEvents(receiveOutput: { coinDetail in
                    self.repository.saveCoinDetail(coinDetail)
                })
                .eraseToAnyPublisher()
        }
    }
}
