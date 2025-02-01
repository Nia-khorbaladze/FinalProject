//
//  SaveUsernameUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol SaveUsernameUseCaseProtocol {
    func execute(userId: String, username: String) async throws
}
