//
//  BuyCoinViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 21.01.25.
//

import UIKit
import FirebaseAuth

final class BuyCoinViewModel {
    private(set) var selectedAmount: Double = 0 {
        didSet {
            updateCryptoAmount()
            updateButtonState()
            onAmountUpdate?()
        }
    }
    private(set) var cryptoAmountString: String = "0.00"
    private(set) var cryptoAmountValue: Double = 0.0
    private(set) var isButtonActive: Bool = false
    
    private let coinSymbol: String
    private let currentPrice: Double
    private let coinName: String
    private let imageURL: String
    var onAmountUpdate: (() -> Void)?
    private let savePurchasedCoinUseCase: SavePurchasedCoinUseCase
    
    init(coinSymbol: String, currentPrice: Double, coinName: String, imageURL: String, savePurchasedCoinUseCase: SavePurchasedCoinUseCase) {
        self.coinSymbol = coinSymbol.uppercased()
        self.currentPrice = currentPrice
        self.coinName = coinName
        self.imageURL = imageURL
        self.savePurchasedCoinUseCase = savePurchasedCoinUseCase
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
        return "\(cryptoAmountString) \(coinSymbol)"
    }
    
    private func updateCryptoAmount() {
        cryptoAmountValue = selectedAmount / currentPrice
        cryptoAmountString = String(format: "%.8f", cryptoAmountValue)
    }
    
    private func updateButtonState() {
        isButtonActive = selectedAmount > 0
    }
    
    func savePurchase() async throws {
        guard let currentUser = Auth.auth().currentUser else {
            throw NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "User is not logged in"])
        }
        
        let userID = currentUser.uid

        try await savePurchasedCoinUseCase.execute(
            userID: userID,
            coinSymbol: coinSymbol,
            coinName: coinName,
            amount: cryptoAmountValue,
            imageURL: imageURL
        )
    }

}
