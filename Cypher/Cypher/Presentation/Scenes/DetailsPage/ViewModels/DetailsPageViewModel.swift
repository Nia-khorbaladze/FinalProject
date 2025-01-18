//
//  DetailsPageViewModel.swift
//  Cypher
//
//  Created by Nkhorbaladze on 18.01.25.
//

import Foundation
import Combine

final class DetailsPageViewModel: ObservableObject {
    private let fetchCoinDetailUseCase: FetchCoinDetailUseCase
    private var cancellables = Set<AnyCancellable>()
    
    @Published var coinDetail: CoinDetailModel?
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var isFavorited: Bool = false
    
    init(fetchCoinDetailUseCase: FetchCoinDetailUseCase) {
        self.fetchCoinDetailUseCase = fetchCoinDetailUseCase
    }
    
    func fetchCoinDetails(coinName: String) {
        isLoading = true
        
        fetchCoinDetailUseCase.execute(name: coinName)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                switch completion {
                case .failure(let error):
                    self.error = error.localizedDescription
                case .finished:
                    break
                }
            } receiveValue: { [weak self] coinDetail in
                guard let self = self else { return }
                self.coinDetail = coinDetail
            }
            .store(in: &cancellables)
    }
    
    func cleanup() {
        cancellables.removeAll()
    }
    
    func toggleFavorite() {
        isFavorited.toggle()
    }
}


