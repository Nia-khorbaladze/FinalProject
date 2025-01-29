//
//  SuccessfulAuthViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation
import FirebaseAuth

final class SuccessfulAuthViewModel {
    private let walletAddressUseCase: WalletAddressUseCaseProtocol
    
    init(walletAddressUseCase: WalletAddressUseCaseProtocol) {
        self.walletAddressUseCase = walletAddressUseCase
    }
    
    func saveWalletAddress(completion: @escaping (Result<Void, Error>) -> Void) async {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        let walletAddresses: [String: String] = [
            "Ethereum": CryptoAddressGenerator.generateEthereumAddress(),
            "Bitcoin": CryptoAddressGenerator.generateBitcoinAddress(),
            "Solana": CryptoAddressGenerator.generateSolanaAddress()
        ]
        
        do {
            try await walletAddressUseCase.saveWalletAddresses(for: userID, addresses: walletAddresses)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

