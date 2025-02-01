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
    private let walletAddressUseCase: GetWalletAddressUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var walletAddresses: (([WalletData]) -> Void)?
    var isLoading: ((Bool) -> Void)?
    var errorMessage: ((Error) -> Void)?

    init(walletAddressUseCase: GetWalletAddressUseCaseProtocol) {
        self.walletAddressUseCase = walletAddressUseCase
    }

    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
    
    func fetchWalletData() {
        isLoading?(true)
        
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        
        Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let addresses = try await walletAddressUseCase.getWalletAddresses(for: userID)
                await MainActor.run {
                    self.walletAddresses?(addresses)
                    self.isLoading?(false)
                }
            } catch {
                await MainActor.run { 
                    self.errorMessage?(error)
                    self.isLoading?(false)
                }
            }
        }
    }
}

