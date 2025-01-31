//
//  SavePurchasedCoinUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 31.01.25.
//

import Foundation

protocol SavePurchasedCoinUseCaseProtocol {
    func execute(userID: String, coinSymbol: String, coinName: String, amount: Double, imageURL: String) async throws
}
