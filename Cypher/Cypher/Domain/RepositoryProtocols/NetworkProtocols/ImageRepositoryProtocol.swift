//
//  ImageRepositoryProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 19.01.25.
//

import Foundation
import Combine
import UIKit

protocol ImageRepositoryProtocol {
    func fetchImage(from url: URL) -> AnyPublisher<UIImage, NetworkError>
}
