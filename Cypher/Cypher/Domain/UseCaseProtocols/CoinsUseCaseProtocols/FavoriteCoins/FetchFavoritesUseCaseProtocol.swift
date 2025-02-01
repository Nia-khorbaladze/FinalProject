//
//  FetchFavoritesUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol FetchFavoritesUseCaseProtocol {
    func execute(userID: String) async throws -> [String]
}
