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
    var getGoal: Goal = Goal(id: 0,content: "", completed: false, createdAt: "", categoryId: 0)
    init() {
        //goals = goalRepo.getAllDummy()
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
}
