//
//  HistoryRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import Combine

final class HistoryRepository: HistoryRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://api.coingecko.com/api/v3/coins"
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCryptoHistory(for coinID: String, days: String) -> AnyPublisher<[CoinHistory], NetworkError> {
        let urlString = "\(baseURL)/\(coinID)/market_chart?vs_currency=usd&days=\(days)&interval=daily"

        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
            .tryMap { (response: CoinHistoryResponse) -> [CoinHistory] in
                var history: [CoinHistory] = []
                
                for i in 0..<response.prices.count {
                    let timestamp = response.prices[i][0]
                    let price = response.prices[i][1]
                    let marketCap = response.market_caps[i][1]
                    let totalVolume = response.total_volumes[i][1]
                    
                    history.append(CoinHistory(timestamp: timestamp, price: price, marketCap: marketCap, totalVolume: totalVolume))
                }
                
                return history
            }
            .mapError { error in
                return NetworkError.decodingError(error)
            }
            .eraseToAnyPublisher()
    }

}


