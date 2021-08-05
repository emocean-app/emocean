//
//  CheckinCategoryViewModel.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

class CheckinCategoryViewModel: ObservableObject {
    let repository = CategoryRepository()
    @Published var allData: [Category] = []
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        fetchAllData()
    }
    
    func fetchAllData() {
        repository
            .getAllData()
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] data in
                self?.allData = data
            }
            .store(in: &cancellable)
    }
}
