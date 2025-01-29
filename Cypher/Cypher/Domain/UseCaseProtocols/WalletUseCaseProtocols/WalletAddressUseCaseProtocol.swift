//
//  WalletAddressUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation

protocol WalletAddressUseCaseProtocol {
    func getWalletAddresses(for userID: String) async throws -> [WalletData]
    func saveWalletAddresses(for userId: String, addresses: [String: String]) async throws
}
