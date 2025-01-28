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
            startDebounceTimer()
        }
    }

    var selectedPayCoin: CoinResponse? {
        didSet { startDebounceTimer() }
    }
    var selectedReceiveCoin: CoinResponse? {
        didSet { startDebounceTimer() }
    }

    private let fetchCoinsUseCase: FetchCoinsUseCase
    private let getExchangeRateUseCase: GetExchangeRateUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    private var timer: AnyCancellable?
    private var timeInterval: TimeInterval = 0.3

    init(fetchCoinsUseCase: FetchCoinsUseCase, getExchangeRateUseCase: GetExchangeRateUseCaseProtocol) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.getExchangeRateUseCase = getExchangeRateUseCase
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

    private func startDebounceTimer() {
        timer?.cancel()
        timer = Timer.publish(every: timeInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.calculateReceiveAmount()
            }
    }

    private func calculateReceiveAmount() {
        guard
            let payCoin = selectedPayCoin,
            let receiveCoin = selectedReceiveCoin,
            let payValue = Double(payAmount), payValue > 0
        else {
            receiveAmount = "0"
            return
        }

        getExchangeRateUseCase.execute(from: payCoin.symbol, to: receiveCoin.symbol)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case .failure = completion {
                        self?.receiveAmount = "0"
                    }
                },
                receiveValue: { [weak self] exchangeRate in
                    guard let self = self else { return }
                    let calculatedAmount = payValue * exchangeRate
                    self.receiveAmount = String(format: "%.8f", calculatedAmount)
                }
            )
            .store(in: &cancellables)
    }
}
