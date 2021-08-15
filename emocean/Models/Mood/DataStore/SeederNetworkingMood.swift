//
//  SeederNetworkingMood.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct SeederNetworkingMood {
    private var baseUrl = Constant.baseUrl
    // METHODS
    func getAllMoods() -> AnyPublisher<GetResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)
        return apiService
            .dispatch(request: GetAllMoods())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - REQUESTS
extension SeederNetworkingMood {
    struct GetAllMoods: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/moods"
    }
}

// MARK: - RESPONSE MODELS
extension SeederNetworkingMood {
    struct GetResponse: Codable {
        let moods: [Mood]
    }
}
