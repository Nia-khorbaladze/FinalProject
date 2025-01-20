//
//  ProfilePopupViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 20.01.25.
//

import Foundation

final class ProfilePopupViewModel {
    private let logoutUseCase: LogoutUseCase
    
    init(logoutUseCase: LogoutUseCase = LogoutUseCase()) {
        self.logoutUseCase = logoutUseCase
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        logoutUseCase.execute { result in
            completion(result)
        }
    }
}
