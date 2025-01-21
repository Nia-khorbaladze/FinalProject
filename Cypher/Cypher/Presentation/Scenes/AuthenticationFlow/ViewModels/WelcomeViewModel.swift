//
//  WelcomeViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import SwiftUI

final class WelcomeViewModel {
    var state: AuthenticationState
    var isAgreementAccepted: Bool = false
    
    init(state: AuthenticationState) {
        self.state = state
    }
    
    var isCreateWalletButtonActive: Bool {
        return isAgreementAccepted
    }
    
    func toggleAgreement() {
        isAgreementAccepted.toggle()
    }
    
    func updateState(to newState: AuthenticationState) {
        state = newState
    }
}
