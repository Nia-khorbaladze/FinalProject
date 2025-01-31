//
//  FavoritesViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 17.01.25.
//

import Foundation
import Combine
import FirebaseAuth
import UIKit

final class FavoritesViewModel: ObservableObject {
    private let fetchCoinsUseCase: FetchCoinsUseCase
    private let fetchFavoritesUseCase: FetchFavoritesUseCase
    private let fetchImagesUseCase: ImageUseCaseProtocol
    
    @Published var favoriteCoins: [FavoriteCoin] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    var cancellables = Set<AnyCancellable>()
    
    init(fetchCoinsUseCase: FetchCoinsUseCase, fetchFavoritesUseCase: FetchFavoritesUseCase, fetchImagesUseCase: ImageUseCaseProtocol) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.fetchFavoritesUseCase = fetchFavoritesUseCase
        self.fetchImagesUseCase = fetchImagesUseCase
    }
    
    func fetchFavorites() {
        isLoading = true
        error = nil
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid

        Task {
            do {
                let favoriteNames = try await fetchFavoritesUseCase.execute(userID: userID)
                
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

                        let favoriteCoins = favoriteNames.compactMap { favoriteName in
                            marketData.first { $0.name.lowercased() == favoriteName.lowercased() }
                                .map { marketCoin in
                                    FavoriteCoin(
                                        id: marketCoin.id,
                                        name: marketCoin.name,
                                        imageURL: marketCoin.imageURL,
                                        currentPrice: marketCoin.currentPrice,
                                        changePercentage24h: marketCoin.priceChangePercentage24h,
                                        symbol: marketCoin.symbol
                                    )
                                }
                        }

                        self.favoriteCoins = favoriteCoins
                        self.fetchImages(for: favoriteCoins)
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
    
    private func fetchImages(for coins: [FavoriteCoin]) {
        fetchImagesUseCase.execute(for: coins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedCoins in
                self?.favoriteCoins = updatedCoins
            }
            .store(in: &self.cancellables)
    }
}


