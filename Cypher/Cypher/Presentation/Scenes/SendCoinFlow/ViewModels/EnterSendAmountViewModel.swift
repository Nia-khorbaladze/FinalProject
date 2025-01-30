//
//  EnterSendAmountViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit
import FirebaseAuth

final class EnterSendAmountViewModel {
    private let availableAmount: Double
    private(set) var amount: Double = 0 {
        didSet {
            onAmountUpdate?()
        }
    }
    
    var onAmountUpdate: (() -> Void)?
    
    init(availableAmount: Double) {
        self.availableAmount = availableAmount
    }
    
    func updateAmount(_ amount: Double) {
        self.amount = amount
    }
    
    func formatAmount() -> String {
        return String(format: "%.2f", amount)
    }
    
    func getAvailableAmount() -> String {
        return "\(availableAmount)"
    }
}
