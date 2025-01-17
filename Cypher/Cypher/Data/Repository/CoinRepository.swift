//
//  CoinRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class CoinRepository: CoinRepositoryProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchCoins() -> AnyPublisher<[CoinResponse], NetworkError> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1") else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
    }
}
