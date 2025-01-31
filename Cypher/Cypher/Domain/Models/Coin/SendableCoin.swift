//
//  SendableCoin.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import UIKit

struct SendableCoin: ImageModel {
    let symbol: String
    let name: String
    let totalAmount: Double
    var imageURL: String?
    var image: UIImage?
}
