//
//  FetchCoinsUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class FetchCoinsUseCase: FetchCoinsUseCaseProtocol {
    private let coinRepository: CoinRepositoryProtocol
    private let imageRepository: ImageRepositoryProtocol
    
    init(coinRepository: CoinRepositoryProtocol, imageRepository: ImageRepositoryProtocol) {
        self.coinRepository = coinRepository
        self.imageRepository = imageRepository
    }
    
    func execute() -> AnyPublisher<[CoinResponse], NetworkError> {
        return coinRepository.fetchCoins()
            .flatMap { [weak self] coins -> AnyPublisher<[CoinResponse], NetworkError> in
                guard let self = self else {
                    return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
                }
                let imageRequests = coins.map { coin -> AnyPublisher<CoinResponse, NetworkError> in
                    guard let imageUrl = URL(string: coin.imageURL) else {
                        return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
                    }
                    return self.imageRepository.fetchImage(from: imageUrl)
                        .map { image in
                            var updatedCoin = coin
                            updatedCoin.image = image
                            return updatedCoin
                        }
                        .eraseToAnyPublisher()
                }
                
                return Publishers.MergeMany(imageRequests)
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}
