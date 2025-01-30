//
//  FetchCoinPriceChangeUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import Combine

final class FetchCoinPriceChangeUseCase {
    private let repository: HistoryRepositoryProtocol
    
    init(repository: HistoryRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(for coinID: String) -> AnyPublisher<[Double], NetworkError> {
        repository.fetchCryptoHistory(for: coinID, days: "365")
            .map { history -> [Double] in
                return history.map { $0.price }
            }
            .eraseToAnyPublisher()
    }
}


