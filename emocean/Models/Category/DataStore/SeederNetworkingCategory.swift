//
//  SeederNetworkingCategory.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

struct SeederNetworkingCategory {
    // PROPERTIES
    private var baseUrl = Constant.baseUrl
    // METHODS
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
        var path: String = "api/categories"
    }
}

// MARK: - RESPONSE MODELS
extension SeederNetworkingCategory {
    struct GetResponse: Codable {
        let categories: [Category]
    }
}
