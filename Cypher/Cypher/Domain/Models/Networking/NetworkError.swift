//
//  NetworkError.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation

enum NetworkError: Error {
    case networkError(URLError)
    case decodingError(DecodingError)
    case invalidResponse
    case unknownError(Error)
}
