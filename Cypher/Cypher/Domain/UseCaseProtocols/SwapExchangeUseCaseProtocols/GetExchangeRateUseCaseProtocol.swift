//
//  GetExchangeRateUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation
import Combine

protocol GetExchangeRateUseCaseProtocol {
    func execute(from sourceSymbol: String, to targetSymbol: String) -> AnyPublisher<Double, NetworkError>
}

