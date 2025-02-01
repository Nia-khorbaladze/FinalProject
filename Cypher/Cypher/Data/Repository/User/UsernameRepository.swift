//
//  UsernameRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation
import FirebaseFirestore

final class UsernameRepository: UsernameRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func getUsername(for userId: String) async throws -> String? {
        let userDocRef = db.collection("Users").document(userId)
        let document = try await userDocRef.getDocument()
        return document.data()?["username"] as? String
    }
    
    func saveUsername(for userId: String, username: String) async throws {
        let userDocRef = db.collection("Users").document(userId)
        try await userDocRef.setData(["username": username], merge: true)
    }
}
