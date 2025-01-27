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
    private let fetchCoinsUseCase: FetchCoinsUseCase
    private let fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCase
    private let imageRepository: ImageRepositoryProtocol

    @Published var portfolioCoins: [PortfolioCoin] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    var cancellables = Set<AnyCancellable>()

    init(fetchCoinsUseCase: FetchCoinsUseCase, fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCase, imageRepository: ImageRepositoryProtocol) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.fetchPurchasedCoinsUseCase = fetchPurchasedCoinsUseCase
        self.imageRepository = imageRepository
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
                self.error = error.localizedDescription
            }
        }
    }
    
    private func fetchImages(for coins: [PortfolioCoin]) {
        for (index, coin) in coins.enumerated() {
            guard let imageURLString = coin.imageURL, let imageURL = URL(string: imageURLString) else { continue }
            
            imageRepository.fetchImage(from: imageURL)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] image in
                    self?.portfolioCoins[index].image = image
                })
                .store(in: &cancellables)
        }
    }
}
