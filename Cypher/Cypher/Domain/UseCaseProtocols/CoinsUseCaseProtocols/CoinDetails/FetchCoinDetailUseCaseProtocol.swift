//
//  FetchCoinDetailUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import Combine

protocol FetchCoinDetailUseCaseProtocol {
    func execute(name: String) -> AnyPublisher<CoinDetailModel, NetworkError>
}
