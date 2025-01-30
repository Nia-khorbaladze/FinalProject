//
//  DetailsPageViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine
import FirebaseAuth

final class DetailsPageViewModel: ObservableObject {
    private let fetchCoinDetailUseCase: FetchCoinDetailUseCase
    private let fetchPriceChangeUseCase: FetchCoinPriceChangeUseCase
    private let saveFavoriteUseCase: SaveFavoriteCoinUseCase
    private let removeFavoriteUseCase: RemoveFavoriteCoinUseCase
    private let isFavoriteUseCase: IsFavoriteCoinUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var coinDetail: CoinDetailModel?
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var isFavorited: Bool = false
    @Published var priceHistory: [String: [Double]] = [:]
    
    init(fetchCoinDetailUseCase: FetchCoinDetailUseCase, fetchPriceChangeUseCase: FetchCoinPriceChangeUseCase, saveFavoriteUseCase: SaveFavoriteCoinUseCase, removeFavoriteUseCase: RemoveFavoriteCoinUseCase, isFavoriteUseCase: IsFavoriteCoinUseCase) {
        self.fetchCoinDetailUseCase = fetchCoinDetailUseCase
        self.fetchPriceChangeUseCase = fetchPriceChangeUseCase
        self.saveFavoriteUseCase = saveFavoriteUseCase
        self.removeFavoriteUseCase = removeFavoriteUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
    }
    
    func fetchCoinDetails(coinName: String) {
        isLoading = true
        
        fetchCoinDetailUseCase.execute(name: coinName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
                self.checkIfFavorite(coinName: coinName)
                self.fetchPriceHistory(for: coinDetail.id)
            }
            .store(in: &cancellables)
    }
    
    func fetchPriceHistory(for coinID: String) {
        fetchPriceChangeUseCase.execute(for: coinID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            }, receiveValue: { [weak self] history in
                self?.priceHistory = [
                    "1D": Array(history.prefix(24)),
                    "1W": Array(history.prefix(7)),
                    "1M": Array(history.prefix(30)),
                    "1Y": Array(history.prefix(365)),
                    "ALL": history
                ]
            })
            .store(in: &cancellables)
    }
    
    
    func checkIfFavorite(coinName: String) {
        guard let currentUser = Auth.auth().currentUser else {
            self.isFavorited = false
            return
        }
        let userID = currentUser.uid

        Task { [weak self] in
            guard let self = self else { return }
            do {
                let favoriteStatus = try await self.isFavoriteUseCase.execute(userID: userID, coinName: coinName)
                await MainActor.run {
                    self.isFavorited = favoriteStatus
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                }
            }
        }
    }
    
    func toggleFavorite() {
        guard let coinName = coinDetail?.name else {
            return
        }
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let userID = currentUser.uid
        
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                if self.isFavorited {
                    try await self.removeFavoriteUseCase.execute(userID: userID, coinName: coinName)
                } else {
                    try await self.saveFavoriteUseCase.execute(userID: userID, coinName: coinName)
                }
                
                await MainActor.run {
                    self.isFavorited.toggle()
                }
            } catch {
                await MainActor.run {
                    self.error = error.localizedDescription
                }
            }
        }
    }
}


