//
//  SaveWalletAddressUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

final class SaveWalletAddressUseCase: SaveWalletAddressUseCaseProtocol {
    private let repository: WalletAddressRepositoryProtocol

    init(repository: WalletAddressRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveWalletAddresses(for userID: String, addresses: [String: String]) async throws {
        try await repository.saveWalletAddresses(for: userID, addresses: addresses)
    }
}
