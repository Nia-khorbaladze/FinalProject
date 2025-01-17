//
//  CoinRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

protocol CoinRepositoryProtocol {
    func fetchCoins() -> AnyPublisher<[CoinResponse], NetworkError>
}
