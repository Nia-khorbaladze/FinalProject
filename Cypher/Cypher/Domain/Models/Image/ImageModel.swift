//
//  ImageModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 30.01.25.
//

import Foundation
import UIKit

protocol ImageModel {
    var imageURL: String? { get }
    var image: UIImage? { get set }
}
