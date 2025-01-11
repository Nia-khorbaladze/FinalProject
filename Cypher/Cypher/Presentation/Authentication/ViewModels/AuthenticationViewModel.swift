//
//  AuthenticationViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import SwiftUI

final class AuthenticationViewModel: ObservableObject {
    @Published var state: AuthenticationState
    
    init(state: AuthenticationState) {
        self.state = state
    }
}
