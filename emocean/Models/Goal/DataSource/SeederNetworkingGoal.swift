//
//  SeederNetworkGoal.swift
//  emocean
//
//  Created by Christian Adiputra on 13/08/21.
//

import Foundation
import Combine
import SwiftUI

struct SeederNetworkingGoal {
    private var baseUrl = Constant.baseUrl
    func postGoal(body: [String: Any]) ->
    AnyPublisher<PostResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)
        let header: [String:String] = [
            "content-type": "application/json"
        ]
        return apiService
            .dispatch(request: PostGoal(headers: header,body: body))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getAllGoal(status: Bool) -> AnyPublisher<GetResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)

        let header: [String:String] = [
            "content-type": "application/json"
        ]
        let queryparams: [String:String]? = [
            "deviceId": "\(UIDevice.current.identifierForVendor?.uuidString ?? "")"
        ]

        return apiService
            .dispatch(request: GetAllGoals(headers: header, queryParams: queryparams))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func deleteGoal(id: Int) -> AnyPublisher<DeleteResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)

        let header: [String:String] = [
            "content-type": "application/json"
        ]
        
        var deletedId =  id
        return apiService
            .dispatch(request: DeleteGoal(path: "api/goals/\(deletedId)", headers: header))
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
        var queryParams: [String : String]?
    }
    
    struct PostGoal: Request {
        typealias ReturnType = PostResponse
        var method: HTTPMethod = .POST
        var headers: [String : String]?
        var path: String = "api/goals"
        var body: [String: Any]?
    }
    
    struct DeleteGoal: Request {
        typealias ReturnType = DeleteResponse
        var path: String = ""
        var headers: [String : String]?
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
    
    struct DeleteResponse: Codable {
        let id: Int
    }
}
