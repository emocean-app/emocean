//
//  SeederNetworkGoal.swift
//  emocean
//
//  Created by Christian Adiputra on 13/08/21.
//

import Foundation
import Combine

struct SeederNetworkingGoal {
    private var baseUrl = Constant.baseUrl
    
    
    func postGoal(body: [String: Any]) ->
    AnyPublisher<PostResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)
        return apiService
            .dispatch(request: PostGoal(body: body))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getAllGoal(status: Bool) -> AnyPublisher<GetResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)

        var header: [String:String] = [
            "Content-Type": "application/json"
        ]
        var body: [String:Any] = [
            "deviceId": "80BE2160-E98C-4C9A-B77F-66ECEB04EBAC",
            "status": status
        ]

        return apiService
            .dispatch(request: GetAllGoals(headers: header, body: body))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//MARK: - REQUEST
extension SeederNetworkingGoal {
    
    struct GetAllGoals: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/goals"
        var headers: [String : String]?
        var body: [String : Any]?
    }
    
    struct PostGoal: Request {
        typealias ReturnType = PostResponse
        var method: HTTPMethod = .POST
        var path: String = "api/goals"
        var body: [String: Any]?
    }
}

//MARK: - RESPONSE MODELS
extension SeederNetworkingGoal {
    struct GetResponse: Codable {
        let goals: [Goal]
    }
    
    struct PostResponse: Codable {
        let deviceId: String
    }
}
