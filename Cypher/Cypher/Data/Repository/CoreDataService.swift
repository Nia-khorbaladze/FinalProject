//
//  CoreDataService.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import CoreData

final class CoreDataService: CoreDataServiceProtocol {
    private let context = PersistenceController.shared.container.viewContext

    func saveCoinDetail(_ coin: CoinDetailModel) {
        let fetchRequest: NSFetchRequest<CoinDetail> = CoinDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", coin.name)
        
        if let existingCoin = try? context.fetch(fetchRequest).first {
            existingCoin.currentPrice = coin.currentPrice
            existingCoin.marketCap = coin.marketCap
            existingCoin.totalSupply = coin.totalSupply ?? 0.0
            existingCoin.circulatingSupply = coin.circulatingSupply ?? 0.0
            existingCoin.maxSupply = coin.maxSupply ?? 0.0
            existingCoin.coinDescription = coin.description.en
            existingCoin.id = coin.id
            existingCoin.symbol = coin.symbol
            existingCoin.name = coin.name
            existingCoin.lastUpdated = Date()
            existingCoin.priceChange24h = coin.priceChange24h
            existingCoin.priceChangePercentage24h = coin.priceChangePercentage24h
        } else {
            let newCoin = CoinDetail(context: context)
            newCoin.id = coin.id
            newCoin.symbol = coin.symbol
            newCoin.name = coin.name
            newCoin.currentPrice = coin.currentPrice
            newCoin.marketCap = coin.marketCap
            newCoin.totalSupply = coin.totalSupply ?? 0.0
            newCoin.circulatingSupply = coin.circulatingSupply ?? 0.0
            newCoin.maxSupply = coin.maxSupply ?? 0.0
            newCoin.coinDescription = coin.description.en
            newCoin.lastUpdated = Date()
            newCoin.priceChange24h = coin.priceChange24h
            newCoin.priceChangePercentage24h = coin.priceChangePercentage24h
        }
        
        try? context.save()
    }

    func fetchCoinDetail(by name: String) -> CoinDetailModel? {
        let fetchRequest: NSFetchRequest<CoinDetail> = CoinDetail.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        guard let coin = try? context.fetch(fetchRequest).first else { return nil }
        
        let marketData = CoinDetailModel.MarketData(
            currentPrice: CoinDetailModel.PriceData(usd: coin.currentPrice),
            marketCap: CoinDetailModel.PriceData(usd: coin.marketCap),
            totalSupply: coin.totalSupply,
            circulatingSupply: coin.circulatingSupply,
            maxSupply: coin.maxSupply,
            priceChange24h: coin.priceChange24h,
            priceChangePercentage24h: coin.priceChangePercentage24h
        )
        
        let description = CoinDetailModel.Description(en: coin.coinDescription)
        
        var model = CoinDetailModel(
            id: coin.id ?? "",
            symbol: coin.symbol ?? "",
            name: coin.name ?? "",
            description: description,
            marketData: marketData
        )
        
        model.lastUpdated = coin.lastUpdated
        return model
    }
}
