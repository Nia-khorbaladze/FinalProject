//
//  CoinHistory.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation

struct CoinHistory: Codable {
    let timestamp: TimeInterval
    let price: Double
    let marketCap: Double
    let totalVolume: Double
}

struct CoinHistoryResponse: Codable {
    let prices: [[Double]]
    let market_caps: [[Double]]
    let total_volumes: [[Double]]
}

