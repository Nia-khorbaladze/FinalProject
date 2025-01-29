//
//  WalletIconProvider.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import UIKit

class WalletIconProvider {
    func fetchIcon(for coin: String) -> UIImage? {
        switch coin.lowercased() {
        case "bitcoin":
            return UIImage(named: "bitcoin")
        case "ethereum":
            return UIImage(named: "ethereum")
        case "solana":
            return UIImage(named: "solana")
        default:
            return nil
        }
    }
}
