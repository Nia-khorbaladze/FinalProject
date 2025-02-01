//
//  PortfolioViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import Foundation
import Combine
import FirebaseAuth

final class PortfolioViewModel: ObservableObject {
    private let fetchCoinsUseCase: FetchCoinsUseCaseProtocol
    private let fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCaseProtocol
    private let fetchImagesUseCase: ImageUseCaseProtocol

    @Published var portfolioCoins: [PortfolioCoin] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    var cancellables = Set<AnyCancellable>()

    init(fetchCoinsUseCase: FetchCoinsUseCaseProtocol, fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCaseProtocol, fetchImagesUseCase: ImageUseCaseProtocol) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.fetchPurchasedCoinsUseCase = fetchPurchasedCoinsUseCase
        self.fetchImagesUseCase = fetchImagesUseCase
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

    func fetchPortfolio() {
        isLoading = true
        error = nil
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid

        Task {
            do {
                let purchasedCoins = try await fetchPurchasedCoinsUseCase.execute(userID: userID)
                
                fetchCoinsUseCase.execute()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { [weak self] completion in
                        switch completion {
                        case .finished:
                            self?.isLoading = false
                        case .failure(let networkError):
                            self?.error = networkError.localizedDescription
                            self?.isLoading = false
                        }
                    }, receiveValue: { [weak self] marketData in
                        guard let self = self else { return }
                        
                        let combinedCoins = purchasedCoins.compactMap { purchasedCoin in
                            marketData.first { $0.symbol.lowercased() == purchasedCoin.symbol.lowercased() }
                                .map { marketCoin in
                                    PortfolioCoin(
                                        id: purchasedCoin.id.uuidString,
                                        symbol: purchasedCoin.symbol,
                                        name: purchasedCoin.name,
                                        totalAmount: purchasedCoin.totalAmount,
                                        currentPrice: marketCoin.currentPrice,
                                        worthInUSD: purchasedCoin.totalAmount * marketCoin.currentPrice,
                                        changePercentage24h: marketCoin.priceChangePercentage24h,
                                        imageURL: marketCoin.imageURL
                                    )
                                }
                        }

                        self.portfolioCoins = combinedCoins
                        self.fetchImages(for: combinedCoins)
                    })
                    .store(in: &self.cancellables)
            } catch {
                await MainActor.run { [weak self] in
                    self?.error = error.localizedDescription
                    self?.isLoading = false
                }
            }
        }
    }
    
    private func fetchImages(for coins: [PortfolioCoin]) {
        fetchImagesUseCase.execute(for: coins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedCoins in
                self?.portfolioCoins = updatedCoins
            }
            .store(in: &self.cancellables)
    }
}
