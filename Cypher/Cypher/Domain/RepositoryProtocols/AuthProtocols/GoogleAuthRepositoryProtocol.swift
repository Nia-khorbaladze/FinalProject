//
//  GoogleAuthRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import Foundation

protocol GoogleAuthRepositoryProtocol {
    func signIn(completion: @escaping (Result<User, Error>) -> Void)
}
