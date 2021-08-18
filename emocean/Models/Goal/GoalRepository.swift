//
//  GoalRepository.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation
import Combine

struct GoalRepository {
    typealias Entity = Goal
    
    private var staticStore = SeederStaticGoal()
    private var networkStore = SeederNetworkingGoal()
    private var cancellables = Set<AnyCancellable>()
    
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {
        
        return networkStore
            .getAllGoal(status: false)
            .map({ data -> [Entity] in
                return data.goals
            })
            .eraseToAnyPublisher()
        
    }
    
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
    
//        func addGoal() {
//            let baseUrl = Constant.baseUrl
//            let deviceId = UIDevice.current.identifierForVendor?.uuidString
//            let goal: [String: Any] = ["deviceId": deviceId,
//                                       "content": "bakso telor",
//                                       "categoryId": 5]
//            let apiService = APIService(baseURL: baseUrl)
//            apiService.dispatch(request: AddGoal(body: goal))
//                .sink(receiveCompletion: { result in
//                    print(UIDevice.current.identifierForVendor?.uuidString)
//                    print(result)
//                }, receiveValue: { _ in })
//                .store(in: &cancellable)
//        }
}
