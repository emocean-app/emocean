//
//  MoodRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct MoodRepository {
    typealias Entity = Mood
    
    private var staticStore = SeederStaticMood()
    private var networkStore = SeederNetworkingMood()
    private var cancellables = Set<AnyCancellable>()
    
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {

        return networkStore
            .getAllMoods()
            .map({ data -> [Entity] in
                return data.data
            })
            .eraseToAnyPublisher()
    }
    
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
