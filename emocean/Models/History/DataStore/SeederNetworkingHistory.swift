//
//  SeederNetworkingHistory.swift
//  emocean
//
//  Created by Farrel Anshary on 24/08/21.
//

import Foundation
import Combine

struct SeederNetworkingHistory {
    // PROPERTIES
    private let baseUrl = Constant.baseUrl
    // METHODS
    func getHistory(params: [String: String]) -> AnyPublisher<GetResponse, NetworkRequestError> {
        return APIService(baseURL: baseUrl)
            .dispatch(request: GetHistory(queryParams: params))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - REQUESTS
extension SeederNetworkingHistory {
    struct GetHistory: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/journals/history"
        var queryParams: [String : String]?
    }
}

// MARK: - RESPONSE MODEL
extension SeederNetworkingHistory {
    struct GetResponse: Codable {
        let journals: [History]
    }
}
