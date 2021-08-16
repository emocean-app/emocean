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
    
    func getAllGoal() -> AnyPublisher<GetResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)
        
        return apiService
            .dispatch(request: GetAllGoals())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//MARK: - REQUEST
extension SeederNetworkingGoal {
    
    struct GetAllGoals: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/goals"
    }
    
}

//MARK: - RESPONSE MODELS
extension SeederNetworkingGoal {
    struct GetResponse: Codable {
        let goals: [Goal]
    }
}
