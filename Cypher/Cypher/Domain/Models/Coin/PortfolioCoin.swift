//
//  PortfolioCoin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation
import UIKit

struct PortfolioCoin: Identifiable, ImageModel {
    let id: String
    let symbol: String
    let name: String
    let totalAmount: Double
    let currentPrice: Double
    let worthInUSD: Double
    let changePercentage24h: Double
    let imageURL: String?
    var image: UIImage? = nil
}
