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
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1") else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
    }
    
    func fetchCoinDetail(name: String) -> AnyPublisher<CoinDetailModel, NetworkError> {
        let lowercaseName = name.lowercased()
        
        cleanupExpiredCoinDetails()
        
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(lowercaseName)") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        if let cachedCoin = coreDataService.fetchCoinDetail(by: lowercaseName),
           let lastUpdated = cachedCoin.lastUpdated,
           Date().timeIntervalSince(lastUpdated) < cacheTimeout {
            return Just(cachedCoin)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }
        
        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func saveCoinDetail(_ coin: CoinDetailModel) {
        coreDataService.saveCoinDetail(coin)
    }
    
    func getCoinDetail(name: String) -> CoinDetailModel? {
        return coreDataService.fetchCoinDetail(by: name)
    }
    
    func cleanupExpiredCoinDetails() {
        coreDataService.cleanupExpiredCoinDetails()
    }
}
