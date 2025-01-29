//
//  WalletAddressUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation

final class WalletAddressUseCase: WalletAddressUseCaseProtocol {
    private let repository: WalletAddressRepositoryProtocol
    private let iconProvider: WalletIconProvider

    init(repository: WalletAddressRepositoryProtocol, iconProvider: WalletIconProvider) {
        self.repository = repository
        self.iconProvider = iconProvider
    }

    func getWalletAddresses(for userID: String) async throws -> [WalletData] {
        let walletAddresses = try await repository.getWalletAddresses(for: userID) ?? [:]

        return walletAddresses.map { coin, address in
            WalletData(coin: coin, address: address, iconImage: iconProvider.fetchIcon(for: coin))
        }
    }

    func saveWalletAddresses(for userID: String, addresses: [String: String]) async throws {
        try await repository.saveWalletAddresses(for: userID, addresses: addresses)
    }
}
