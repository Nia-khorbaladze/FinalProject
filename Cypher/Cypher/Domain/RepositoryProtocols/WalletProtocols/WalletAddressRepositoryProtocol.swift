//
//  WalletAddressRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation

protocol WalletAddressRepositoryProtocol {
    func getWalletAddresses(for userId: String) async throws -> [String: String]?
    func saveWalletAddresses(for userId: String, addresses: [String: String]) async throws
}
