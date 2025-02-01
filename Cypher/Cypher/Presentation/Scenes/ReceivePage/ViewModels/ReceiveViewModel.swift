//
//  ReceiveViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation
import FirebaseAuth
import Combine

final class WalletViewModel {
    private let walletAddressUseCase: WalletAddressUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var walletAddresses: (([WalletData]) -> Void)?
    var isLoading: ((Bool) -> Void)?
    var errorMessage: ((Error) -> Void)?

    init(walletAddressUseCase: WalletAddressUseCaseProtocol) {
        self.walletAddressUseCase = walletAddressUseCase
    }

    func fetchWalletData() {
        isLoading?(true)
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        
        Task {
            do {
                let addresses = try await walletAddressUseCase.getWalletAddresses(for: userID)
                await MainActor.run { [weak self] in
                    self?.walletAddresses?(addresses)
                    self?.isLoading?(false)
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.errorMessage?(error)
                    self?.isLoading?(false)
                }
            }
        }
    }
}

