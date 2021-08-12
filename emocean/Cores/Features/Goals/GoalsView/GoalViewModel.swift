//
//  GoalViewModel.swift
//  emocean
//
//  Created by Christian Adiputra on 03/08/21.
//

import Foundation

class GoalViewModel: ObservableObject {
    
    @Published var goals: [Goal] = []
    init() {
        getGoals()
    }
    
    func getGoals() {
        let newGoals = [
            Goal(goal: "makan nasi seminggu sekali", category: "Work", date: "Sunday, 25 January", status: true),
            Goal(goal: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak  daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd", category: "Relationship", date: "Monday, 26 January", status: false),
            Goal(goal: "makan daging anjing dengan sayur kol", category: "Covid", date: "Tuesday, 27 January", status: true)
        ]
        goals.append(contentsOf: newGoals)
    }
    
    func delete(indexSet: IndexSet) {
        goals.remove(atOffsets: indexSet)
    }
    
}

