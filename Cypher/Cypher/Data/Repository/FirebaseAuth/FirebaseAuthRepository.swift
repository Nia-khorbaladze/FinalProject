//
//  FirebaseAuthRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 13.01.25.
//

import FirebaseAuth

final class FirebaseAuthRepository: AuthRepository {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = authResult {
                let user = User(id: result.user.uid, email: result.user.email ?? "", isNewUser: false)
                if KeychainManager.shared.save(key: "userId", value: result.user.uid) {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.keychainSaveFailed))
                }
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                if let authError = error as NSError?,
                   authError.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    completion(.failure(AuthError.emailAlreadyInUse))
                } else {
                    completion(.failure(AuthError.unknown(error)))
                }
            } else if let result = authResult {
                let user = User(id: result.user.uid, email: result.user.email ?? "", isNewUser: true)
                if KeychainManager.shared.save(key: "userId", value: result.user.uid) {
                    completion(.success(user))
                } else {
                    completion(.failure(AuthError.keychainSaveFailed))
                }
            }
        }
    }
}


