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
        let document = try await userDocRef.getDocument()
        return document.data()?["walletAddresses"] as? [String: String]
    }
    
    func saveWalletAddresses(for userId: String, addresses: [String: String]) async throws {
        let userDocRef = db.collection("Users").document(userId)
        try await userDocRef.setData(["walletAddresses": addresses], merge: true)
    }
}
