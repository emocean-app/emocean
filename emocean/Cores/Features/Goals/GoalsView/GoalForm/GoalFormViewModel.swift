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
    private var goalRepo = GoalRepository()
    private var postResponse = ""
    var goalpost = Goalpost(
        deviceId: "\(UIDevice.current.identifierForVendor?.uuidString ?? "simulator")",
        content: "",
        categoryId: 5)
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
    
    func addGoal() {
        goalRepo
            .postData(body: goalpost)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                case .finished:
                    print("Finsihed post Goal")
                    print(self.postResponse)
                }
            } receiveValue: { [weak self] data in
                self?.postResponse = data
            }
            .store(in: &cancellable)
    }

}
