//
//  SeederNetworkingCheckin.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct SeederNetworkingCheckin {
    // PROPERTIES
    private var baseUrl = Constant.baseUrl
    // METHODS
    func postCheckin(body: [String: Any]) -> AnyPublisher<PostResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)
        let postCheckin = PostCheckin(body: body)
        print(postCheckin)
        return apiService
            .dispatch(request: postCheckin)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
// MARK: - REQUESTS

extension SeederNetworkingCheckin {
    struct PostCheckin: Request {
        typealias ReturnType = PostResponse
        var method: HTTPMethod = .POST
        var path: String = "api/journals"
        var body: [String: Any]?
        var headers: [String : String]? = [
            "Content-Type" : "application/json"
        ]
    }
}

// MARK: - RESPONSE MODEL

extension SeederNetworkingCheckin {
    struct PostResponse: Codable {
        let deviceId: String
    }
}
