//
//  FavoriteCoinsRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 26.01.25.
//

import Foundation

protocol FavoriteCoinsRepositoryProtocol {
    func saveFavorite(userID: String, coinName: String) async throws
    func removeFavorite(userID: String, coinName: String) async throws
    func isFavorite(userID: String, coinName: String) async throws -> Bool
}
