//
//  IsFavoriteCoinUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol IsFavoriteCoinUseCaseProtocol {
    func execute(userID: String, coinName: String) async throws -> Bool
}
