//
//  AuthManager.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import FirebaseAuth

final class AuthManager {
    static let shared = AuthManager()
    
    private init() {}
    
    func isUserLoggedIn() -> Bool {
        if let userId = KeychainManager.shared.retrieve(key: "userId"),
           !userId.isEmpty {
            return true
        }
        return false
    }
}
