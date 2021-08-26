//
//  SeederNetworkingProgress.swift
//  emocean
//
//  Created by Farrel Anshary on 25/08/21.
//

import Foundation
import Combine
import UIKit

struct SeederNetworkingProgress {
    // PROPERTIES
    private let baseUrl = Constant.baseUrl
    private let deviceId = String(UIDevice.current.identifierForVendor!.uuidString)
    // METHODS
    func getProgress() -> AnyPublisher<GetResponse, NetworkRequestError> {
        return APIService(baseURL: baseUrl)
            .dispatch(request: GetProgress(queryParams: ["deviceId": deviceId]))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - REQUESTS
extension SeederNetworkingProgress {
    struct GetProgress: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/journals/progress"
        var queryParams: [String : String]?
    }
}

// MARK: - RESPONSE MODEL
extension SeederNetworkingProgress {
    struct GetResponse: Codable {
        let progress: [Quadrant]
        let mood: Mood
        let total: Int
    }
}
