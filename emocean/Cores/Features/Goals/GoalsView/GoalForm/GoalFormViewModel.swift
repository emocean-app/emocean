//
//  GoalFormViewModel.swift
//  emocean
//
//  Created by Farrel Anshary on 12/08/21.
//

import Foundation
import SwiftUI
import Combine

class GoalFormViewModel: ObservableObject {
    private var categoryRepo = CategoryRepository()
    private var cancellable = Set<AnyCancellable>()

    @Published var categories = [Category]()
    
    init() {
        getAllData()
    }

    private func getAllData() {
        categoryRepo
            .getAllData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                    guard let self = self else {return}
                    self.categories = self.categoryRepo.getAllDummy()
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] data in
                self?.categories = data
            }
            .store(in: &cancellable)
    }
    

}
