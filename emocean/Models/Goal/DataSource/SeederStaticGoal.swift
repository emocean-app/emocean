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
            Goal(id: 1,content: "makan daging anjing" , completed: false, createdAt: "Tuesday, 26 January", categoryId: 3),
            Goal(id: 2,content: "makan daging anjing" , completed: true, createdAt: "Tuesday, 26 January", categoryId: 3),
            Goal(id: 3,content: "makan daging anjing dengan sayur kol" , completed: true, createdAt: "Tuesday, 27 January", categoryId: 2)
        ]
    }
}
