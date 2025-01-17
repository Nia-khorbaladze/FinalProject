//
//  NetworkServiceProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, method: String, headers: [String: String]?, body: Data?, decoder: JSONDecoder) -> AnyPublisher<T, NetworkError>
}
