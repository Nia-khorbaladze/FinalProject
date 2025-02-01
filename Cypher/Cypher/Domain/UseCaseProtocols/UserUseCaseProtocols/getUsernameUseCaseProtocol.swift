//
//  getUsernameUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol GetUsernameUseCaseProtocol {
    func execute(userId: String) async throws -> String?
}
