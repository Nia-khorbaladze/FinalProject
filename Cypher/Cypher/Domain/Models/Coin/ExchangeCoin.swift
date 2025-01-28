//
//  ExchangeCoin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 28.01.25.
//

import Foundation

struct CoinbaseResponse: Codable {
    let data: CoinbaseData
}

struct CoinbaseData: Codable {
    let currency: String
    let rates: [String: String]
}
