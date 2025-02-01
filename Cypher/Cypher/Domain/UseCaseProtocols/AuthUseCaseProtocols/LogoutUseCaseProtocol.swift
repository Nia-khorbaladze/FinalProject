//
//  LogoutUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol LogoutUseCaseProtocol {
    func execute(completion: @escaping (Result<Void, Error>) -> Void)
}
