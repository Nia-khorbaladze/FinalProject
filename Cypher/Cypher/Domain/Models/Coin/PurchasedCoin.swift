//
//  PurchasedCoin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

struct PurchasedCoin: Identifiable, Codable {
    var id = UUID()
    let symbol: String
    let name: String
    let totalAmount: Double
    let imageURL: String?
}
