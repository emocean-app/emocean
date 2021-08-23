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
            Goal(id: 1, deviceId: "",content: "Hello Good Morning" , completed: false, createdAt: "Tuesday, 26 January", category: Category(id: 1, name: "Work")),
            Goal(id: 2, deviceId: "",content: "Bingung bosnya suka marah-marah" , completed: true, createdAt: "Tuesday, 26 January", category: Category(id: 1, name: "Work")),
            Goal(id: 3, deviceId: "",content: "makan daging anjing dengan sayur kol" , completed: true, createdAt: "Tuesday, 27 January", category: Category(id: 1, name: "Work"))
        ]
    }
}
