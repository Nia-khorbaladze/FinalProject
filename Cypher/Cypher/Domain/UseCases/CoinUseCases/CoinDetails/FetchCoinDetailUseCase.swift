//
//  FetchCoinDetailUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class FetchCoinDetailUseCase: FetchCoinDetailUseCaseProtocol {
    private let repository: CoinRepositoryProtocol

    init(repository: CoinRepositoryProtocol) {
        self.repository = repository
    }

    func execute(name: String) -> AnyPublisher<CoinDetailModel, NetworkError> {
        return repository.fetchCoinDetail(name: name)
    }
}
