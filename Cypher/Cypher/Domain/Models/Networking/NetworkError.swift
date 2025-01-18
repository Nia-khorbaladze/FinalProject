//
//  NetworkError.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case decodingError(Error)
    case networkError(Error)
    case invalidURL
    case unknownError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidURL:
            return "Invalid URL"
        case .unknownError(let error):
            return "Unknown error: \(error.localizedDescription)"
        }
    }
}
