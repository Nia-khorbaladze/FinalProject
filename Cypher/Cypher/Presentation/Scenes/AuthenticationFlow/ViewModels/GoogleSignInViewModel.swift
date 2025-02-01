//
//  GoogleSignInViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import Foundation

final class GoogleSignInViewModel: ObservableObject {
    private let googleSignInUseCase: GoogleSignInUseCaseProtocol

    init(googleSignInUseCase: GoogleSignInUseCaseProtocol) {
        self.googleSignInUseCase = googleSignInUseCase
    }

    func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        googleSignInUseCase.signIn(completion: completion)
    }
}
