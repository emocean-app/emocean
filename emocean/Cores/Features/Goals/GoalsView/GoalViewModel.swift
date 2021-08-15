//
//  GoalViewModel.swift
//  emocean
//
//  Created by Christian Adiputra on 03/08/21.
//

import Foundation

class GoalViewModel: ObservableObject {
    
    @Published var goals: [Goal] = []
    private var goalRepo = GoalRepository()
    var getGoal: Goal = Goal(id: 0, goal: "", category: "", date: "", status: false)
    init() {
        goals = goalRepo.getAllDummy()
    }
    
    func delete(indexSet: IndexSet) {
        goals.remove(atOffsets: indexSet)
    }
    
}
