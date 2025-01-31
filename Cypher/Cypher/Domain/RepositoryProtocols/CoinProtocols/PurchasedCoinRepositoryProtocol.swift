//
//  PurchasedCoinRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 22.01.25.
//

import Foundation

protocol PurchasedCoinRepositoryProtocol {
    func savePurchase(userID: String, coinSymbol: String, coinName: String, purchase: Purchase, imageURL: String) async throws
    func fetchPurchasedCoins(userID: String, fetchFromFirebase: Bool) async throws -> [PurchasedCoin] 
}
