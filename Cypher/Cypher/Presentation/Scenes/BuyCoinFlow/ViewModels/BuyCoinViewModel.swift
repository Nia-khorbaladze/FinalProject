//
//  BuyCoinViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import UIKit

final class BuyCoinViewModel {
    private(set) var selectedAmount: Double = 0 {
        didSet {
            updateCryptoAmount()
            updateButtonState()
            onAmountUpdate?()
        }
    }
    private(set) var cryptoAmount: String = "0.00"
    private(set) var isButtonActive: Bool = false
    
    private let coinSymbol: String
    private let currentPrice: Double
    var onAmountUpdate: (() -> Void)?
    
    init(coinSymbol: String, currentPrice: Double) {
        self.coinSymbol = coinSymbol.uppercased()
        self.currentPrice = currentPrice
    }
    
    func updateAmount(_ amount: Double) {
        selectedAmount = amount
    }
    
    func handleQuickAmountTap(_ amount: Double) -> Bool {
        if selectedAmount == amount {
            updateAmount(0)
            return false
        } else {
            updateAmount(amount)
            return true
        }
    }
    
    func formatAmount() -> String {
        return "$ \(Int(selectedAmount))"
    }
    
    func getCryptoDisplay() -> String {
        return "\(cryptoAmount) \(coinSymbol)"
    }
    
    private func updateCryptoAmount() {
        let amount = selectedAmount / currentPrice
        cryptoAmount = String(format: "%.8f", amount)
    }
    
    private func updateButtonState() {
        isButtonActive = selectedAmount > 0
    }
}
