//
//  CheckinRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct CheckinRepository {
    // Type
    typealias Entity = Checkin
    // PROPERTIES
    private var staticStore = SeederStaticCheckin()
    private var networkStore = SeederNetworkingCheckin()
    private var cancellables = Set<AnyCancellable>()
    // METHODS
    func postData(body: Checkin) -> AnyPublisher<String, NetworkRequestError> {
        return networkStore
            .postCheckin(body: body.asDictionary)
            .map({ data in
                return data.deviceId
            })
            .eraseToAnyPublisher()
    }
    func postDummy() -> String {
        return staticStore.postCheckin()
    }
}
