//
//  MoodRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct MoodRepository {
    // TYPE
    typealias Entity = Mood
    // PROPERTIES
    private var staticStore = SeederStaticMood()
    private var networkStore = SeederNetworkingMood()
    private var cancellables = Set<AnyCancellable>()
    // METHODS
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {
        return networkStore
            .getAllMoods()
            .map({ data -> [Entity] in
                return data.moods
            })
            .eraseToAnyPublisher()
    }
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
