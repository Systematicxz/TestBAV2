//
//  ImageModalViewModel.swift
//  TestBAV2
//
//  Created by PEDRO MENDEZ on 27/12/24.
//

import Foundation
import Combine

class ImageModalViewModel: ObservableObject {
    
    @Published var imageURL: String? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRandomDogImage() {
        self.isLoading = true
        self.errorMessage = nil
        
        ApiService.shared.fetchRandomDogImage()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = self.mapError(error)
                }
            }, receiveValue: { [weak self] imageUrl in
                self?.imageURL = imageUrl
            })
            .store(in: &cancellables)
    }
    

    func logout() {
    }
    
    private func mapError(_ error: Error) -> String {
        return error.localizedDescription
    }
}
