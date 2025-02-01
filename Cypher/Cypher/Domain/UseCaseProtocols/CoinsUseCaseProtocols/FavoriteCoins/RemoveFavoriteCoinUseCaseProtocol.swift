//
//  RemoveFavoriteCoinUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol RemoveFavoriteCoinUseCaseProtocol {
    func execute(userID: String, coinName: String) async throws
}
