//
//  HistoryRepository.swift
//  emocean
//
//  Created by Farrel Anshary on 24/08/21.
//

import Foundation
import Combine

struct HistoryRepository {
    typealias Entity = History

    // MARK: - PROPERTIES
    private var staticStore = SeederStaticHistory()
    private var networkStore = SeederNetworkingHistory()
    private var cancellable = Set<AnyCancellable>()

    // MARK: - METHODS
    func getData(params: [String: String]) -> AnyPublisher<[History], NetworkRequestError> {
        return networkStore
            .getHistory(params: params)
            .map({ data -> [Entity] in
                print(data)
                return data.journals
            })
            .eraseToAnyPublisher()
    }

    func getDummy() -> [History] {
        return staticStore.getAllHistory()
    }
}
