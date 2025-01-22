//
//  PurchasedCoinRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 22.01.25.
//

import Foundation

protocol PurchasedCoinRepositoryProtocol {
    func savePurchase(userID: String, coinSymbol: String, purchase: Purchase) async throws
}
