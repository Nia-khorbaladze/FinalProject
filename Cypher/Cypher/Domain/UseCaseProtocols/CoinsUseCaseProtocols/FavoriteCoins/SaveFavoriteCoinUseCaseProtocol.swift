//
//  SaveFavoriteCoinUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

protocol SaveFavoriteCoinUseCaseProtocol {
    func execute(userID: String, coinName: String) async throws
}
