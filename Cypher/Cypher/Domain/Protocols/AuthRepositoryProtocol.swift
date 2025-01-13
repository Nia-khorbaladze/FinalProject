//
//  AuthRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 13.01.25.
//
import Foundation

protocol AuthRepository {
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
