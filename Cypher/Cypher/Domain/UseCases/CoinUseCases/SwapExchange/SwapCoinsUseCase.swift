//
//  SwapCoinsUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation
import Combine

final class SwapCoinsUseCase: SwapCoinsUseCaseProtocol {
    private let getExchangeRateUseCase: GetExchangeRateUseCaseProtocol
    private let repository: PurchasedCoinRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()

    init(getExchangeRateUseCase: GetExchangeRateUseCaseProtocol, repository: PurchasedCoinRepositoryProtocol) {
        self.getExchangeRateUseCase = getExchangeRateUseCase
        self.repository = repository
    }

    func execute(userID: String, payCoin: CoinResponse, receiveCoin: CoinResponse, payAmount: Double ) async throws {
        let exchangeRate = try await withCheckedThrowingContinuation { continuation in
            getExchangeRateUseCase.execute(from: payCoin.symbol, to: receiveCoin.symbol)
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished: break 
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                    },
                    receiveValue: { rate in
                        continuation.resume(returning: rate)
                    }
                )
                .store(in: &cancellables)
        }

        let receiveValue = payAmount * exchangeRate

        try await repository.savePurchase(
            userID: userID,
            coinSymbol: payCoin.symbol.uppercased(),
            coinName: payCoin.name,
            purchase: Purchase(amount: -payAmount,
            timestamp: Date()),
            imageURL: payCoin.imageURL
        )
        try await repository.savePurchase(
            userID: userID,
            coinSymbol: receiveCoin.symbol.uppercased(),
            coinName: receiveCoin.name,
            purchase: Purchase(amount: receiveValue,
            timestamp: Date()),
            imageURL: payCoin.imageURL
        )
    }
}

