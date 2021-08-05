//
//  SeederNetworkingCategory.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

struct SeederNetworkingCategory {
    private var baseUrl = Constant.baseUrl
    
    func getAllCategory() -> AnyPublisher<GetResponse, NetworkRequestError> {
        let apiService = APIService(baseURL: baseUrl)
        
        return apiService
            .dispatch(request: GetAllCategories())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

// MARK: - REQUESTS
extension SeederNetworkingCategory {
    
    struct GetAllCategories: Request {
        typealias ReturnType = GetResponse
        var path: String = "api/category"
    }
    
}

// MARK: - RESPONSE MODELS
extension SeederNetworkingCategory {
    struct GetResponse: Codable {
        let data: [Category]
    }
}
