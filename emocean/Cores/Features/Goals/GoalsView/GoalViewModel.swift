//
//  GoalViewModel.swift
//  emocean
//
//  Created by Christian Adiputra on 03/08/21.
//

import Foundation
import SwiftUI
import Combine

class GoalViewModel: ObservableObject {
    
    @Published var goals: [Goal] = []
    private var cancellable = Set<AnyCancellable>()
    private var goalRepo = GoalRepository()
    var getGoal: Goal = Goal(id: 0, deviceId: "",content: "", completed: false, createdAt: "", category: Category(id: 1, name: "Work"))
    init() {
        //goals = goalRepo.getAllDummy()
        print("\(UIDevice.current.identifierForVendor?.uuidString)")
        fetchData()
    }
    
    func delete(indexSet: IndexSet) {
        goals.remove(atOffsets: indexSet)
    }
    
}

//MARK: - METHODS
extension GoalViewModel {
    func fetchData(){
        goalRepo.getAllData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "" + " goal")
                    guard let self = self else {return}
                    self.goals = self.goalRepo.getAllDummy()
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] data in
                self?.goals = data
            }
            .store(in: &cancellable)

    }
    
    func deleteData(id: Int){
        goalRepo.delData(id: id)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription)
                case .finished:
                    print("Success Del")
                }
            } receiveValue: {_ in }
            .store(in: &cancellable)
    }
}
