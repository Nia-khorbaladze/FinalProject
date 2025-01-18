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
    func fetchCoinDetail(name: String) -> AnyPublisher<CoinDetailModel, NetworkError>  
    func getCoinDetail(name: String) -> CoinDetailModel?
    func saveCoinDetail(_ coinDetail: CoinDetailModel)
}
