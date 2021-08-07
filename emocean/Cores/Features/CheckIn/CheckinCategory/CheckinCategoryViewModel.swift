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
    @Published var categories: [CategorySelection] = []
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        categories = repository.getAllDummy()
        fetchAllData()
    }
    
    func fetchAllData() {
        repository
            .getAllData()
            .map { val -> [CategorySelection] in
                return val.map { CategorySelection(category: $0) }
            }
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                    guard let self = self else {return}
                    self.categories = self.repository.getAllDummy()
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] data in
                self?.categories = data
            }
            .store(in: &cancellable)
    }
}
