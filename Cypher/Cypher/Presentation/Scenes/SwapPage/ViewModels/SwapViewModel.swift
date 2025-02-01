//
//  SwapViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI
import Combine
import FirebaseAuth

final class SwapViewModel: ObservableObject {
    @Published var coins: [CoinResponse] = []
    @Published var purchasedCoins: [PurchasedCoin] = []
    @Published var isLoading: Bool = false
    @Published var error: String?

    @Published var isButtonActive: Bool = false
    @Published var receiveAmount: String = "0"
    @Published var payAmount: String = "0" {
        didSet {
            if let payValue = Double(payAmount),
               let selectedCoin = selectedPayCoin,
               let ownedAmount = purchasedCoins.first(where: { $0.symbol == selectedCoin.symbol.uppercased() })?.totalAmount,
               payValue > 0,
               payValue <= ownedAmount {
                isButtonActive = true
            } else {
                isButtonActive = false
            }
            startDebounceTimer()
        }
    }

    var selectedPayCoin: CoinResponse? {
        didSet { startDebounceTimer() }
    }
    var selectedReceiveCoin: CoinResponse? {
        didSet { startDebounceTimer() }
    }

    private let fetchCoinsUseCase: FetchCoinsUseCaseProtocol
    private let getExchangeRateUseCase: GetExchangeRateUseCaseProtocol
    private let fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let swapCoinsUseCase: SwapCoinsUseCaseProtocol
    
    private var timer: AnyCancellable?
    private var timeInterval: TimeInterval = 0.3

    init(fetchCoinsUseCase: FetchCoinsUseCaseProtocol, getExchangeRateUseCase: GetExchangeRateUseCaseProtocol, fetchPurchasedCoinsUseCase: FetchPurchasedCoinsUseCaseProtocol, swapCoinsUseCase: SwapCoinsUseCaseProtocol) {
        self.fetchCoinsUseCase = fetchCoinsUseCase
        self.getExchangeRateUseCase = getExchangeRateUseCase
        self.fetchPurchasedCoinsUseCase = fetchPurchasedCoinsUseCase
        self.swapCoinsUseCase = swapCoinsUseCase
    }

    func fetchCoins() {
        isLoading = true
        error = nil

        fetchCoinsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] (completion: Subscribers.Completion<NetworkError>) in
                    switch completion {
                    case .finished:
                        self?.isLoading = false
                    case .failure(let networkError):
                        self?.isLoading = false
                        self?.error = networkError.localizedDescription
                    }
                },
                receiveValue: { [weak self] (coins: [CoinResponse]) in
                    self?.coins = coins
                }
            )
            .store(in: &cancellables)
    }

    func fetchPurchasedCoins() {
        isLoading = true
        error = nil

        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let userID = currentUser.uid
        
        Task {
            do {
                let purchasedCoins = try await fetchPurchasedCoinsUseCase.execute(userID: userID)
                await MainActor.run { [weak self] in
                    self?.purchasedCoins = purchasedCoins
                    self?.isLoading = false
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.error = error.localizedDescription
                    self?.isLoading = false
                }
            }
        }
    }
    
    func swapCoins() async -> Bool {
        guard
            let payCoin = selectedPayCoin,
            let receiveCoin = selectedReceiveCoin,
            let payValue = Double(payAmount), payValue > 0,
            let currentUser = Auth.auth().currentUser
        else {
            return false
        }
        
        let userID = currentUser.uid
        
        await MainActor.run {
            isLoading = true
            error = nil
        }
        
        do {
            try await swapCoinsUseCase.execute(
                userID: userID,
                payCoin: payCoin,
                receiveCoin: receiveCoin,
                payAmount: payValue
            )

            await MainActor.run { [weak self] in
                self?.isLoading = false
            }
            return true
        } catch {
            await MainActor.run { [weak self] in
                self?.error = error.localizedDescription
                self?.isLoading = false
            }
            return false
        }
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
