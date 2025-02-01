//
//  LogoutUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 20.01.25.
//

import Foundation
import FirebaseAuth

struct LogoutUseCase: LogoutUseCaseProtocol {
    func execute(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            if KeychainManager.shared.delete(key: "userId") {
                completion(.success(()))
            } else {
                completion(.failure(AuthError.keychainDeleteFailed))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
