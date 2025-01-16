//
//  Coin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import Foundation

struct Coin {
    let name: String
    let symbol: String
    let price: Double
    let changePercentage: Double
    let icon: String 
}

struct OwnedCoin {
    let name: String
    let symbol: String
    let amount: String
    let amountInDollar: Double
    let changePercentage: Double
    let icon: String
}
