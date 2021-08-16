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
    private var networkStore = SeederNetworkingGoal()
    private var cancellables = Set<AnyCancellable>()
    
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {
        
        return networkStore
            .getAllGoal()
            .map({ data -> [Entity] in
                return data.goals
            })
            .eraseToAnyPublisher()
        
    }
    
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
