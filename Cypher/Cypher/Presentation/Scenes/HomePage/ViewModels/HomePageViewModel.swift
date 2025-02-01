//
//  HomePageViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import Foundation
import Combine
import FirebaseAuth

final class HomePageViewModel: ObservableObject {
    
    private let fetchCoinsUseCase: FetchCoinsUseCaseProtocol
    private let purchasedCoinUseCase: FetchPurchasedCoinsUseCaseProtocol
    private let fetchCoinDetailUseCase: FetchCoinDetailUseCaseProtocol
    
    private var portfolioCoins: [PurchasedCoin] = []
    private var allCoins: [CoinResponse] = []
    
    @Published var coins: [CoinResponse] = []
    @Published var totalPortfolioValue: Double = 0.0
    @Published var totalPercentageChange: Double = 0.0
    @Published var totalPriceChange: Double = 0.0
    @Published var isLoading: Bool = false
    @Published var error: String? = nil
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(fetchCoinsUseCase: FetchCoinsUseCaseProtocol, purchasedCoinUseCase: FetchPurchasedCoinsUseCaseProtocol, fetchCoinDetailUseCase: FetchCoinDetailUseCaseProtocol) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.purchasedCoinUseCase = purchasedCoinUseCase
        self.fetchCoinDetailUseCase = fetchCoinDetailUseCase
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
        
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let purchasedCoins = try await purchasedCoinUseCase.execute(userID: userID)
                self.portfolioCoins = purchasedCoins
                
                let coinDetailsPublisher = purchasedCoins.map { coin in
                    self.fetchCoinDetailUseCase.execute(name: coin.name.lowercased())
                        .map { coinDetail in
                            (coin, coinDetail)
                        }
                        .catch { _ in
                            Just((coin, nil))
                        }
                }
                
                Publishers.MergeMany(coinDetailsPublisher)
                    .collect()
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            self.isLoading = false
                        case .failure(let networkError):
                            self.error = networkError.localizedDescription
                            self.isLoading = false
                        }
                    }, receiveValue: { coinDetails in
                        
                        var totalValue: Double = 0.0
                        var totalPriceChange: Double = 0.0
                        var totalWeightedChange: Double = 0.0
                        
                        for (purchasedCoin, coinDetail) in coinDetails {
                            guard let coinDetail = coinDetail else {
                                continue
                            }
                            
                            let coinValue = purchasedCoin.totalAmount * coinDetail.currentPrice
                            totalValue += coinValue
                            
                            let coinPriceChange = coinDetail.priceChange24h
                            totalPriceChange += purchasedCoin.totalAmount * coinPriceChange
                            
                            let coinChangePercentage = coinDetail.priceChangePercentage24h
                            totalWeightedChange += coinValue * (coinChangePercentage / 100)
                        }
                                                
                        self.totalPortfolioValue = totalValue
                        self.totalPriceChange = totalPriceChange
                        
                        if totalValue > 0 {
                            self.totalPercentageChange = (totalWeightedChange / totalValue) * 100
                        } else {
                            self.totalPercentageChange = 0.0
                        }
                    })
                    .store(in: &cancellables)
            } catch {
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
   func fetchCoins() {
        isLoading = true
        error = nil
        
        fetchCoinsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let networkError):
                    self.isLoading = false
                    self.error = networkError.localizedDescription
                }
            }, receiveValue: { [weak self] coins in
                self?.coins = coins
            })
            .store(in: &cancellables)
    }
}


