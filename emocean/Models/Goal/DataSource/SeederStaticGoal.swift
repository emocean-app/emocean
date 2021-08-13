//
//  SeederStaticGoal.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation
struct SeederStaticGoal {
    func getData() -> [Goal] {
        return [
            Goal(goal: "makan nasi seminggu sekali", category: "Work", date: "Sunday, 25 January", status: true),
            Goal(goal: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak  daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd", category: "Relationship", date: "Monday, 26 January", status: false),
            Goal(goal: "makan daging anjing dengan sayur kol", category: "Covid", date: "Tuesday, 27 January", status: true)
        ]
    }
}
