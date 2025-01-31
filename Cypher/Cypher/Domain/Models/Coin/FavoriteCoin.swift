//
//  FavoriteCoin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation
import UIKit

struct FavoriteCoin: ImageModel {
    let id: String
    let name: String
    var image: UIImage?
    var imageURL: String?
    let currentPrice: Double
    let changePercentage24h: Double
    let symbol: String
}
