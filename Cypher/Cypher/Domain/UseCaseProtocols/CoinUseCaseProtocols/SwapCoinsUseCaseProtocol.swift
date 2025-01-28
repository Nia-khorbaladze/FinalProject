//
//  SwapCoinsUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation

protocol SwapCoinsUseCaseProtocol {
    func execute(userID: String, payCoin: CoinResponse, receiveCoin: CoinResponse, payAmount: Double) async throws
}
