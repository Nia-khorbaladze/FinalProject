//
//  GetWalletAddressUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol GetWalletAddressUseCaseProtocol {
    func getWalletAddresses(for userID: String) async throws -> [WalletData]
}
