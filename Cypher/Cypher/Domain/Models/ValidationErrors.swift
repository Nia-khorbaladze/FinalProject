//
//  ValidationErrors.swift
//  Cypher
//
//  Created by Nkhorbaladze on 14.01.25.
//

import Foundation

struct ValidationErrors: Error {
    let errors: [ValidationError]
}
