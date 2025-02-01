//
//  RegisterUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import Foundation

struct RegisterUseCase: RegisterUseCaseProtocol {
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }

    func execute(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        repository.register(email: email, password: password, completion: completion)
    }
}
