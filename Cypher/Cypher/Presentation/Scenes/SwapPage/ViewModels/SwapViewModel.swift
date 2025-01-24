//
//  SwapViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI
import Combine

class SwapViewModel: ObservableObject {
    @Published var coins: [CoinResponse] = []
    @Published var isLoading: Bool = false
    @Published var error: String?
    
    @Published var isButtonActive: Bool = false
    @Published var receiveAmount: String = "0"
    @Published var payAmount: String = "0" {
        didSet {
            isButtonActive = (Double(payAmount) ?? 0) > 0
        }
    }

    private let fetchCoinsUseCase: FetchCoinsUseCase
    private var cancellables: Set<AnyCancellable> = []

    init(fetchCoinsUseCase: FetchCoinsUseCase) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
    }

    func fetchCoins() {
        isLoading = true
        error = nil

        fetchCoinsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let networkError):
                    self?.isLoading = false
                    self?.error = networkError.localizedDescription
                }
            }, receiveValue: { [weak self] coins in
                self?.coins = coins
            })
            .store(in: &cancellables)
    }
}

