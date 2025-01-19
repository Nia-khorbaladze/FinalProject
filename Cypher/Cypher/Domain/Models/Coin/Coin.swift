//
//  Coin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 15.01.25.
//

import Foundation
import UIKit

struct Coin: Identifiable {
    let id = UUID()
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

struct CoinResponse: Identifiable, Decodable {
    let id: String
    let symbol: String
    let name: String
    let currentPrice: Double
    let priceChangePercentage24h: Double
    let marketCap: Double
    let imageURL: String
    var image: UIImage? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCap = "market_cap"
        case imageURL = "image"
    }
}
