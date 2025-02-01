//
//  FetchCoinPriceChangeUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import Combine

protocol FetchCoinPriceChangeUseCaseProtocol {
    func execute(for coinID: String) -> AnyPublisher<[Double], NetworkError>
}
