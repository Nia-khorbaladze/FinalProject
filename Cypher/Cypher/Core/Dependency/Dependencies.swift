//
//  Dependencies.swift
//  Cypher
//
//  Created by Nkhorbaladze on 19.01.25.
//

import Foundation

final class Dependencies {
    static let shared = Dependencies()
    
    // MARK: - Services
    let coreDataService: CoreDataServiceProtocol
    let networkService: NetworkServiceProtocol
    
    // MARK: - Repositories
    private(set) lazy var coinRepository: CoinRepositoryProtocol = {
        CoinRepository(
            networkService: networkService,
            coreDataService: coreDataService
        )
    }()
    
    // MARK: - Use Cases
    private(set) lazy var fetchCoinDetailUseCase: FetchCoinDetailUseCase = {
        FetchCoinDetailUseCase(repository: coinRepository)
    }()
    
    private init() {
        self.coreDataService = CoreDataService()
        self.networkService = NetworkService()
    }
}
