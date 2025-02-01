//
//  ProfilePopupViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 20.01.25.
//

import Foundation
import FirebaseAuth

final class ProfilePopupViewModel {
    let logoutUseCase: LogoutUseCaseProtocol
    let getUsernameUseCase: GetUsernameUseCaseProtocol
    let clearCacheUseCase: ClearCacheUseCaseProtocol
    
    init(logoutUseCase: LogoutUseCaseProtocol, getUsernameUseCase: GetUsernameUseCaseProtocol, clearCacheUseCase: ClearCacheUseCaseProtocol) {
        self.logoutUseCase = logoutUseCase
        self.getUsernameUseCase = getUsernameUseCase
        self.clearCacheUseCase = clearCacheUseCase
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        logoutUseCase.execute { result in
            if case .success = result {
                self.clearCacheUseCase.execute() 
            }
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
