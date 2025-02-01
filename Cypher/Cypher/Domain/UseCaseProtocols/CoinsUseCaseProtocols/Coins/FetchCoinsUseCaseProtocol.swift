//
//  FetchCoinsUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import Combine

protocol FetchCoinsUseCaseProtocol {
    func execute() -> AnyPublisher<[CoinResponse], NetworkError>
}
