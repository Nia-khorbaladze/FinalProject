//
//  AuthError.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import Foundation

enum AuthError: Error {
    case noPresentingViewController
    case tokenNotFound
    case emailAlreadyInUse
    case keychainSaveFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .noPresentingViewController:
            return "There is no presenting view controller."
        case .tokenNotFound:
            return "Authentication token was not found."
        case .emailAlreadyInUse:
            return "This email is already in use. Please log in or use a different email."
        case .keychainSaveFailed:
            return "Failed to save data in the Keychain."
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
