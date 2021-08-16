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
            Goal(id: 1, content: "makan nasi", category: "work", createdAt: "Sunday, 25 January", completed: true),
            Goal(id: 2, content: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak  daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd",category: "Relationship", createdAt: "Monday, 26 January", completed: false),
            Goal(id: 3, content: "makan daging anjing dengan sayur kol",category: "Relationship", createdAt: "Tuesday, 27 January", completed: true)
        ]
    }
}
