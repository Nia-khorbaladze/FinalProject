//
//  ImageRepository.swift
//  Cypher
//
//  Created by Nkhorbaladze on 19.01.25.
//

import Foundation
import Combine
import UIKit

final class ImageRepository: ImageRepositoryProtocol {
    func fetchImage(from url: URL) -> AnyPublisher<UIImage, NetworkError> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw NetworkError.invalidResponse
                }
                return image
            }
            .mapError { error -> NetworkError in
                if let urlError = error as? URLError {
                    return .networkError(urlError)
                } else {
                    return .unknownError(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

