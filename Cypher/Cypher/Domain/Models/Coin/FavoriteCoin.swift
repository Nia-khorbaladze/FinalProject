//
//  FavoriteCoin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation
import UIKit

struct FavoriteCoin {
    let id: String
    let name: String
    let imageURL: String
    var image: UIImage?
    let currentPrice: Double
    let changePercentage24h: Double
    let symbol: String
}
