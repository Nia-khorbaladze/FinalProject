//
//  WalletAddressUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation

class WalletAddressUseCase: WalletAddressUseCaseProtocol {
    private let repository: WalletAddressRepositoryProtocol

    init(repository: WalletAddressRepositoryProtocol) {
        self.repository = repository
    }

    func getWalletAddresses(for userId: String) async throws -> [String: String]? {
        return try await repository.getWalletAddresses(for: userId)
    }

    func saveWalletAddresses(for userId: String, addresses: [String: String]) async throws {
        try await repository.saveWalletAddresses(for: userId, addresses: addresses)
    }
}
