//
//  CoreDataServiceProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation

protocol CoreDataServiceProtocol {
    func saveCoinDetail(_ coin: CoinDetailModel)
    func fetchCoinDetail(by name: String) -> CoinDetailModel? 
}
