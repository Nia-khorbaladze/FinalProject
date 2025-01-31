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
    private let coreDataService: CoreDataServiceProtocol

    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }

    func fetchImage(from url: URL) -> AnyPublisher<UIImage, NetworkError> {
        let cacheKey = url.absoluteString

        if let cachedImage = fetchCachedImage(forKey: cacheKey) {
            return Just(cachedImage)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
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
            .handleEvents(receiveOutput: { image in
                self.cacheImage(image, forKey: cacheKey)
            })
            .eraseToAnyPublisher()
    }

    private func fetchCachedImage(forKey key: String) -> UIImage? {
        if let image = coreDataService.fetchImage(forKey: key) {
            return image
        }
        return nil
    }

    private func cacheImage(_ image: UIImage, forKey key: String) {
        coreDataService.saveImage(image, forKey: key)
    }
}


