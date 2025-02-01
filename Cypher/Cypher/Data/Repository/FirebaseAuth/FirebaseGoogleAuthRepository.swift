//
//  FirebaseGoogleAuthRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import FirebaseAuth
import GoogleSignIn

final class FirebaseGoogleAuthRepository: GoogleAuthRepositoryProtocol {
    func signIn(completion: @escaping (Result<User, Error>) -> Void) {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene,
              let presentingVC = windowScene.windows.first?.rootViewController else {
            completion(.failure(AuthError.noPresentingViewController))
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let authentication = result?.user.idToken?.tokenString else {
                completion(.failure(AuthError.tokenNotFound))
                return
            }

            let credential = GoogleAuthProvider.credential(
                withIDToken: authentication,
                accessToken: result?.user.accessToken.tokenString ?? ""
            )
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                } else if let authResult = authResult {
                    let isNewUser = authResult.additionalUserInfo?.isNewUser ?? false
                    let user = User(id: authResult.user.uid, email: authResult.user.email ?? "", isNewUser: isNewUser)
                    if KeychainManager.shared.save(key: "userId", value: authResult.user.uid) {
                        completion(.success(user))
                    } else {
                        completion(.failure(AuthError.keychainSaveFailed))
                    }
                }
            }
        }
    }
}
