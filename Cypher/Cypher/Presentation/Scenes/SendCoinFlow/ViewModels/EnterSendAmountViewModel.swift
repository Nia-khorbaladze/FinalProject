//
//  EnterSendAmountViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import UIKit
import FirebaseAuth

final class EnterSendAmountViewModel {
    private(set) var amount: Double = 0 {
        didSet {
            onAmountUpdate?()
        }
    }
    
    var onAmountUpdate: (() -> Void)?
    
    func updateAmount(_ amount: Double) {
        self.amount = amount
    }
    
    func formatAmount() -> String {
        return String(format: "%.2f", amount)
    }
}
