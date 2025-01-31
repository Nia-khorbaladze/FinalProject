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
    private let coreDataService: CoreDataServiceProtocol
    private let cacheTimeout: TimeInterval = 300

    init(networkService: NetworkServiceProtocol, coreDataService: CoreDataServiceProtocol) {
        self.networkService = networkService
        self.coreDataService = coreDataService
    }

    func fetchCoins() -> AnyPublisher<[CoinResponse], NetworkError> {
        let cacheKey = "coinsList"

        coreDataService.cleanupExpiredCache(expiration: cacheTimeout)

        let (cachedCoins, timestamp) = coreDataService.fetchResponse(forKey: cacheKey, as: [CoinResponse].self)
        
        if let cachedCoins = cachedCoins,
           let timestamp = timestamp,
           Date().timeIntervalSince(timestamp) < cacheTimeout {
            return Just(cachedCoins)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }

        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1") else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }

        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { coins in
                self.coreDataService.saveResponse(coins, forKey: cacheKey)
            })
            .eraseToAnyPublisher()
    }
    
    func fetchCoinDetail(name: String) -> AnyPublisher<CoinDetailModel, NetworkError> {
        let lowercaseName = name.lowercased()

        coreDataService.cleanupExpiredCache(expiration: cacheTimeout)

        let (cachedCoin, timestamp) = coreDataService.fetchResponse(forKey: lowercaseName, as: CoinDetailModel.self)
        
        if let cachedCoin = cachedCoin,
           let timestamp = timestamp,
           Date().timeIntervalSince(timestamp) < cacheTimeout {
            return Just(cachedCoin)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }

        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(lowercaseName)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { coin in
                self.coreDataService.saveResponse(coin, forKey: lowercaseName)
            })
            .eraseToAnyPublisher()
    }
}
