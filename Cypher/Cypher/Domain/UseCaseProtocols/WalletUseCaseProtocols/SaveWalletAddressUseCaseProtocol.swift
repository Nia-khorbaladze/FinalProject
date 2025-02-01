//
//  SaveWalletAddressUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol SaveWalletAddressUseCaseProtocol {
    func saveWalletAddresses(for userId: String, addresses: [String: String]) async throws
}
