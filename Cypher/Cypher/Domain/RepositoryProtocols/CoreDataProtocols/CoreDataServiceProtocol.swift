//
//  CoreDataServiceProtocol.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import UIKit

protocol CoreDataServiceProtocol {
    func saveResponse<T: Codable>(_ object: T, forKey key: String)
    func fetchResponse<T: Codable>(forKey key: String, as type: T.Type) -> (object: T?, timestamp: Date?)
    func cleanupExpiredCache(forKey key: String, expiration: TimeInterval)
    func deleteCache(forKey key: String)
    func saveImage(_ image: UIImage, forKey key: String)
    func fetchImage(forKey key: String) -> UIImage?
}
