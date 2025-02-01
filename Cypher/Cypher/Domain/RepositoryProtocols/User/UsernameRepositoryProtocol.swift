//
//  UsernameRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol UsernameRepositoryProtocol {
    func getUsername(for userId: String) async throws -> String?
    func saveUsername(for userId: String, username: String) async throws
}
