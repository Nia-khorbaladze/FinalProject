//
//  ProfilePopupViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 20.01.25.
//

import Foundation
import FirebaseAuth

final class ProfilePopupViewModel {
    let logoutUseCase: LogoutUseCase
    let getUsernameUseCase: GetUsernameUseCaseProtocol
    
    init(logoutUseCase: LogoutUseCase, getUsernameUseCase: GetUsernameUseCaseProtocol) {
        self.logoutUseCase = logoutUseCase
        self.getUsernameUseCase = getUsernameUseCase
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        logoutUseCase.execute { result in
            completion(result)
        }
    }
    
    func getUsername() async throws -> String? {
        guard let currentUser = Auth.auth().currentUser else {
            return nil
        }
        
        let userID = currentUser.uid
        
        do {
            return try await getUsernameUseCase.execute(userId: userID)
        } catch {
            return nil
        }
    }
}
