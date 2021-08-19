//
//  MoodRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct MoodRepository {
    // MARK: TYPE
    typealias Entity = Mood
    // MARK: PROPERTIES
    private var staticStore = SeederStaticMood()
    private var networkStore = SeederNetworkingMood()
    private var cancellables = Set<AnyCancellable>()
    // MARK: METHODS
    /// Get all data from server
    /// - Returns: A publisher
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {
        return networkStore
            .getAllMoods()
            .map({ data -> [Entity] in
                return data.moods
            })
            .eraseToAnyPublisher()
    }
    /// Get all data dummy
    /// - Returns: An array of Entity
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
