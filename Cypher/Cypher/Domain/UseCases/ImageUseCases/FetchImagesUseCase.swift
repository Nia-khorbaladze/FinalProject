//
//  FetchImagesUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import Combine
import UIKit

final class FetchImagesUseCase: ImageUseCaseProtocol {
    private let imageRepository: ImageRepositoryProtocol

    init(imageRepository: ImageRepositoryProtocol) {
        self.imageRepository = imageRepository
    }

    func execute<T: ImageModel>(for items: [T]) -> AnyPublisher<[T], Never> {
        let publishers = items.enumerated().map { index, item -> AnyPublisher<T, Never> in
            guard let imageURLString = item.imageURL, let imageURL = URL(string: imageURLString) else {
                return Just(item).eraseToAnyPublisher()
            }
            
            return imageRepository.fetchImage(from: imageURL)
                .map { image in
                    var updatedItem = item
                    updatedItem.image = image
                    return updatedItem
                }
                .replaceError(with: item)
                .eraseToAnyPublisher()
        }

        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
}
