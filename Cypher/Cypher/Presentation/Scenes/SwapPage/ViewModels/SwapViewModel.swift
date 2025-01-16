//
//  SwapViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 16.01.25.
//

import SwiftUI
import Combine

import SwiftUI
import Combine

class SwapViewModel: ObservableObject {
    @Published var payAmount: String = "0" {
        didSet {
            isButtonActive = (Double(payAmount) ?? 0) > 0
        }
    }
    @Published var isButtonActive: Bool = false
}

