//
//  GoalViewModel.swift
//  emocean
//
//  Created by Christian Adiputra on 03/08/21.
//

import Foundation

class GoalViewModel: ObservableObject {
    
    var goals = [
        "makan nasi seminggu sekali",
        "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd",
        "makan daging anjing dengan sayur kol"
    ]
    
    var categories = ["Work", "Relationship", "Covid"]
    var dates = ["Sunday, 25 January", "Monday, 26 January", "Tuesday, 27 January"]
    var status = [ "True" , "False" , "True" , "False" ]
    
    func getData() -> [Goal] {
        return [
            Goal(goal: "makan nasi seminggu sekali", category: "Work", date: "Sunday, 25 January", status: true),
            Goal(goal: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd", category: "Relationship", date: "Monday, 26 January", status: false),
            Goal(goal: "makan daging anjing dengan sayur kol", category: "Covid", date: "Tuesday, 27 January", status: true)
        ]
    }
}

struct Goal: Hashable {
    
    let goal: String
    let category: String
    let date: String
    let status: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(goal)
    }
}

