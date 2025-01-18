//
//  CoinDetailModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation

struct CoinDetailModel: Codable {
    let id: String
    let symbol: String
    let name: String
    let description: Description
    private let marketData: MarketData
    
    var currentPrice: Double { marketData.currentPrice.usd }
    var marketCap: Double { marketData.marketCap.usd }
    var totalSupply: Double? { marketData.totalSupply }
    var circulatingSupply: Double? { marketData.circulatingSupply }
    var maxSupply: Double? { marketData.maxSupply }
    var lastUpdated: Date?
    var priceChange24h: Double { marketData.priceChange24h ?? 0.0 }
    var priceChangePercentage24h: Double { marketData.priceChangePercentage24h ?? 0.0 }

    init(id: String, symbol: String, name: String, description: Description, marketData: MarketData) {
        self.id = id
        self.symbol = symbol
        self.name = name
        self.description = description
        self.marketData = marketData
        self.lastUpdated = Date()
    }

    struct Description: Codable {
        let en: String?
    }
    
    struct MarketData: Codable {
        let currentPrice: PriceData
        let marketCap: PriceData
        let totalSupply: Double?
        let circulatingSupply: Double?
        let maxSupply: Double?
        let priceChange24h: Double?
        let priceChangePercentage24h: Double?
        
        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
            case marketCap = "market_cap"
            case totalSupply = "total_supply"
            case circulatingSupply = "circulating_supply"
            case maxSupply = "max_supply"
            case priceChange24h = "price_change_24h"
            case priceChangePercentage24h = "price_change_percentage_24h"
        }
    }
    
    struct PriceData: Codable {
        let usd: Double
    }

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description
        case marketData = "market_data"
    }
}
