//
//  GetWalletAddressUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

final class GetWalletAddressUseCase: GetWalletAddressUseCaseProtocol {
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
}
