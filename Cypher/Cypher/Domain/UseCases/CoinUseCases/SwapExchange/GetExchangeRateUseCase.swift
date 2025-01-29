//
//  GetExchangeRateUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation
import Combine

final class GetExchangeRateUseCase: GetExchangeRateUseCaseProtocol {
    private let repository: ExchangeRateRepositoryProtocol
    
    init(repository: ExchangeRateRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(from sourceSymbol: String, to targetSymbol: String) -> AnyPublisher<Double, NetworkError> {
        return repository.getExchangeRate(from: sourceSymbol, to: targetSymbol)
    }
}
