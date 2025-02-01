//
//  GoogleSignInUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol GoogleSignInUseCaseProtocol {
    func signIn(completion: @escaping (Result<User, Error>) -> Void)
}
