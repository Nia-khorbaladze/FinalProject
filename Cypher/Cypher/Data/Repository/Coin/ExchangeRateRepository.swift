//
//  ExchangeRateRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation
import Combine

final class ExchangeRateRepository: ExchangeRateRepositoryProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getExchangeRate(from sourceSymbol: String, to targetSymbol: String) -> AnyPublisher<Double, NetworkError> {
        guard let url = URL(string: "https://api.coinbase.com/v2/exchange-rates?currency=\(sourceSymbol.uppercased())") else {
            return Fail(error: NetworkError.invalidResponse).eraseToAnyPublisher()
        }
        
        return networkService.request(url: url, method: "GET", headers: nil, body: nil, decoder: JSONDecoder())
            .tryMap { (response: CoinbaseResponse) -> Double in
                guard
                    let targetRateString = response.data.rates[targetSymbol.uppercased()],
                    let targetRate = Double(targetRateString)
                else {
                    throw NetworkError.invalidResponse
                }
                return targetRate
            }
            .mapError { error in
                error as? NetworkError ?? NetworkError.unknownError(error)
            }
            .eraseToAnyPublisher()
    }
}

