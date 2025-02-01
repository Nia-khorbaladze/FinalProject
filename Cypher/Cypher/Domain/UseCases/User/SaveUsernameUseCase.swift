//
//  SaveUsernameUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

final class SaveUsernameUseCase: SaveUsernameUseCaseProtocol {
    private let usernameRepository: UsernameRepositoryProtocol

    init(usernameRepository: UsernameRepositoryProtocol) {
        self.usernameRepository = usernameRepository
    }
    
    func execute(userId: String, username: String) async throws {
        try await usernameRepository.saveUsername(for: userId, username: username)
    }
}
