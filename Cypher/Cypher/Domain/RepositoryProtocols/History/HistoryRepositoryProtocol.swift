//
//  HistoryRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import Combine

protocol HistoryRepositoryProtocol {
    func fetchCryptoHistory(for coinID: String, days: String) -> AnyPublisher<[CoinHistory], NetworkError>
}
