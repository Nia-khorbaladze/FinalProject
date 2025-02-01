//
//  CreateUsernameViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import FirebaseAuth

final class CreateUsernameViewModel {
    let saveUsernameUseCase: SaveUsernameUseCaseProtocol
    
    init(saveUsernameUseCase: SaveUsernameUseCaseProtocol) {
        self.saveUsernameUseCase = saveUsernameUseCase
    }
    
    func saveUsername(username: String) async throws {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        
        let userID = currentUser.uid
        
        do {
            try await saveUsernameUseCase.execute(userId: userID, username: username)
        } catch {
            print("Failed to save username: \(error.localizedDescription)")
        }
    }

}
