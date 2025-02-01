//
//  ChooseCoinViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import FirebaseAuth
import Combine

final class ChooseCoinViewModel {
    private let fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCaseProtocol
    private let fetchImagesUseCase: ImageUseCaseProtocol
    
    init(fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCaseProtocol, fetchImagesUseCase: ImageUseCaseProtocol) {
        self.fetchPurchasedCoinsUseCase = fetchPurchasedCoinsUseCase
        self.fetchImagesUseCase = fetchImagesUseCase
    }
    
    var isLoading: ((Bool) -> Void)?
    var cancellables = Set<AnyCancellable>()
    private var sendableCoins: [SendableCoin] = []
    var didUpdateCoins: (([SendableCoin]) -> Void)?
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func fetchCoins() {
        isLoading?(true)
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let purchasedCoins = try await fetchPurchasedCoinsUseCase.execute(userID: userID)
                
                let coins: [SendableCoin] = purchasedCoins.map { purchasedCoin in
                    SendableCoin(
                        symbol: purchasedCoin.symbol,
                        name: purchasedCoin.name,
                        totalAmount: purchasedCoin.totalAmount,
                        imageURL: purchasedCoin.imageURL,
                        image: nil
                    )
                }
                self.sendableCoins = coins
                self.fetchImages(for: sendableCoins)
            } catch {
                self.isLoading?(false)
            }
        }
        
    }
    
    private func fetchImages(for coins: [SendableCoin]) {
        fetchImagesUseCase.execute(for: coins)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] updatedCoins in
                self?.sendableCoins = updatedCoins
                self?.isLoading?(false)
                
                self?.didUpdateCoins?(updatedCoins)
            }
            .store(in: &self.cancellables)
    }
}
