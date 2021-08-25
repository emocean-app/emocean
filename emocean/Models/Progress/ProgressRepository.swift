//
//  ProgressRepository.swift
//  emocean
//
//  Created by Farrel Anshary on 25/08/21.
//

import Foundation
import Combine

struct ProgressRepository {
    typealias Entity = Progress

    // MARK: - PROPERTIES
    private var staticStore = SeederStaticProgress()
    private var networkStore = SeederNetworkingProgress()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - METHODS
    func getData() -> AnyPublisher<Progress, NetworkRequestError> {
        return networkStore
            .getProgress()
            .map({ data -> Entity in
                print(data)
                return Progress(progress: data.progress, mood: data.mood, total: data.total)
            })
            .eraseToAnyPublisher()
    }

    func getDummy() -> Progress {
        return staticStore.getProgress()
    }
}
