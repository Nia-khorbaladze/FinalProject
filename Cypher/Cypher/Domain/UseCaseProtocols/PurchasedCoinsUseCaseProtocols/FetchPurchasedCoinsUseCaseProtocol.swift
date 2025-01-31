//
//  FetchPurchasedCoinsUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation

protocol FetchPurchasedCoinsUseCaseProtocol {
    func execute(userID: String) async throws -> [PurchasedCoin]
}
