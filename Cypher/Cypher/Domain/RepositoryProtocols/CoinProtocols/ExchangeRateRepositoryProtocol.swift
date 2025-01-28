//
//  ExchangeRateRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation
import Combine

protocol ExchangeRateRepositoryProtocol {
    func getExchangeRate(from sourceSymbol: String, to targetSymbol: String) -> AnyPublisher<Double, NetworkError>
}
