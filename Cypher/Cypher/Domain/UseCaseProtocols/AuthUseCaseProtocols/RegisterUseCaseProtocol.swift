//
//  RegisterUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol RegisterUseCaseProtocol {
    func execute(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
