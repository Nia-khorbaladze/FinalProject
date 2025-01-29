//
//  WalletAddressRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 29.01.25.
//

import Foundation
import FirebaseFirestore

class WalletAddressRepository: WalletAddressRepositoryProtocol {
    private let db = Firestore.firestore()
    
    func getWalletAddresses(for userId: String) async throws -> [String: String]? {
        let userDocRef = db.collection("Users").document(userId)

        return try await withCheckedThrowingContinuation { continuation in
            userDocRef.getDocument { document, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }

                if let data = document?.data(), let walletAddresses = data["walletAddresses"] as? [String: String] {
                    continuation.resume(returning: walletAddresses)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
    func saveWalletAddresses(for userId: String, addresses: [String: String]) async throws {
        let userDocRef = db.collection("Users").document(userId)

        return try await withCheckedThrowingContinuation { continuation in
            userDocRef.setData(["walletAddresses": addresses], merge: true) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }

}
