//
//  CryptoAddressGenerator.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation

struct CryptoAddressGenerator {
    static func generateEthereumAddress() -> String {
        let hexChars = "0123456789abcdef"
        let address = (0..<40).map { _ in hexChars.randomElement()! }
        return "0x" + String(address)
    }

    static func generateBitcoinAddress() -> String {
        let base58Chars = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
        let address = (0..<40).map { _ in base58Chars.randomElement()! }
        return "1" + String(address)
    }

    static func generateSolanaAddress() -> String {
        let base58Chars = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
        let address = (0..<40).map { _ in base58Chars.randomElement()! }
        return String(address)
    }
}
