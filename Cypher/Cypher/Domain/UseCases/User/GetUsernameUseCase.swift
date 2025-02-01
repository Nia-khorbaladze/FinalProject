//
//  GetUsernameUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation


final class GetUsernameUseCase: GetUsernameUseCaseProtocol {
    private let usernameRepository: UsernameRepositoryProtocol

    init(usernameRepository: UsernameRepositoryProtocol) {
        self.usernameRepository = usernameRepository
    }
    
    func execute(userId: String) async throws -> String? {
        return try await usernameRepository.getUsername(for: userId)
    }
}
