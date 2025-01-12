//
//  ValidationError.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import Foundation

enum ValidationError: LocalizedError {
    case email
    case emailEmpty
    case password
    case passwordEmpty
    case confirmPassword
    case confirmPasswordEmpty
    
    var errorDescription: String? {
        switch self {
        case .email:
            return "Enter a valid email address."
        case .emailEmpty:
            return "Email is required"
        case .password:
            return "Password must be 8+ characters, include uppercase, lowercase, a number, and a special character."
        case .passwordEmpty:
            return "Password is required"
        case .confirmPassword:
            return "Passwords don't match."
        case .confirmPasswordEmpty:
            return "Password confirmation is required."
        }
    }
}
