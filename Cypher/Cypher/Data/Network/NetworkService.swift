//
//  NetworkService.swift
//  Cypher
//
//  Created by Nkhorbaladze on 11.01.25.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }

    func request<T: Decodable>(url: URL,
                               method: String = "GET",
                               headers: [String: String]? = nil,
                               body: Data? = nil,
                               decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<T, NetworkError> {
        var request = URLRequest(url: url)
        request.httpMethod = method
        if let headers = headers {
            headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        }
        if let body = body {
            request.httpBody = body
        }

        return session.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let response = output.response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return output.data
            }
            .decode(type: T.self, decoder: decoder)
            .mapError { error -> NetworkError in
                if let urlError = error as? URLError {
                    return .networkError(urlError)
                } else if let decodingError = error as? DecodingError {
                    return .decodingError(decodingError)
                } else {
                    return .unknownError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}
