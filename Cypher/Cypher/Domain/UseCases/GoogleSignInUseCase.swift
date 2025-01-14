//
//  GoogleSignInUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import Foundation

struct GoogleSignInUseCase {
    private let repository: GoogleAuthRepository

    init(repository: GoogleAuthRepository) {
        self.repository = repository
    }

    func signIn(completion: @escaping (Result<User, Error>) -> Void) {
        repository.signIn(completion: completion)
    }
}
