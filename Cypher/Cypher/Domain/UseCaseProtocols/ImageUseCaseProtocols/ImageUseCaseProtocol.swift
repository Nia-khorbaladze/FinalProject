//
//  ImageUseCaseProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import Combine

protocol ImageUseCaseProtocol {
    func execute<T: ImageModel>(for items: [T]) -> AnyPublisher<[T], Never>
}
