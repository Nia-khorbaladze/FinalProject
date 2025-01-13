//
//  CredentialsInputViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 12.01.25.
//

import Foundation

final class CredentialsInputViewModel: ObservableObject {
    private let loginUseCase: LoginUseCase
    private let registerUseCase: RegisterUseCase
    
    init(loginUseCase: LoginUseCase, registerUseCase: RegisterUseCase) {
        self.loginUseCase = loginUseCase
        self.registerUseCase = registerUseCase
    }
    
    func validateEmail(_ email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&#])[A-Za-z\\d@$!%*?&#]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return predicate.evaluate(with: password)
    }
    
    func validateFields(email: String, password: String, confirmPassword: String?, isRegistration: Bool) -> [ValidationError] {
        var errors: [ValidationError] = []
        
        if email.isEmpty {
            errors.append(.emailEmpty)
        } else if !validateEmail(email) {
            errors.append(.email)
        }
        
        if password.isEmpty {
            errors.append(.passwordEmpty)
        } else if !validatePassword(password) {
            errors.append(.password)
        }
        
        if isRegistration {
            if let confirmPassword = confirmPassword {
                if confirmPassword.isEmpty {
                    errors.append(.confirmPasswordEmpty)
                } else if password != confirmPassword {
                    errors.append(.confirmPassword)
                }
            } else {
                errors.append(.confirmPasswordEmpty)
            }
        }
        
        return errors
    }
    
    func authenticate(
        email: String,
        password: String,
        confirmPassword: String?,
        isRegistration: Bool,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        let errors = validateFields(email: email, password: password, confirmPassword: confirmPassword, isRegistration: isRegistration)

        guard errors.isEmpty else {
            completion(.failure(ValidationErrors(errors: errors)))
            return
        }

        if isRegistration {
            registerUseCase.execute(email: email, password: password, completion: completion)
        } else {
            loginUseCase.execute(email: email, password: password, completion: completion)
        }
    }

}
