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
                completion(.success(user))
            }
        }
    }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let result = authResult {
                let user = User(id: result.user.uid, email: result.user.email ?? "", isNewUser: true)
                completion(.success(user))
            }
        }
    }
}


