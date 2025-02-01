//
//  ClearCacheUseCase.swift
//  Cypher
//
//  Created by Nkhorbaladze on 01.02.25.
//

import Foundation

final class ClearCacheUseCase: ClearCacheUseCaseProtocol {
    private let coreDataService: CoreDataServiceProtocol
    
    init(coreDataService: CoreDataServiceProtocol) {
        self.coreDataService = coreDataService
    }
    
    func execute() {
        coreDataService.clearAllData()
    }
}
