//
//  SeederNetworkingQuestion.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct SeederNetworkingQuestion {
    // PROPERTIES
    private let baseUrl = Constant.baseUrl
    // METHODS
    func getCheckinQuestion() -> AnyPublisher<GetResponse, NetworkRequestError> {
        return APIService(baseURL: baseUrl)
            .dispatch(request: GetCheckinQuestions())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - REQUESTS

extension SeederNetworkingQuestion {
    struct GetCheckinQuestions: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/journals/questions"
    }
}

// MARK: - RESPONSE MODEL

extension SeederNetworkingQuestion {
    struct GetResponse: Codable {
        let questions: [String: [Question]]
    }
}
