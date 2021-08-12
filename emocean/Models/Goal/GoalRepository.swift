//
//  GoalRepository.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation
import Combine

struct GoalRepository {
    typealias Entity = Goal
    
    private var staticStore = SeederStaticGoal()
    
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
