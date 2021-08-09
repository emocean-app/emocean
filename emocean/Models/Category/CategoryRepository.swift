//
//  CategoryRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

struct CategoryRepository: Repository {
    
    typealias Entity = Category
    
    private var staticStore = SeederStaticCategory()
    private var networkStore = SeederNetworkingCategory()
    private var cancellables = Set<AnyCancellable>()
    
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {

        return networkStore
            .getAllCategory()
            .map({ data -> [Entity] in
                return data.data
            })
            .eraseToAnyPublisher()
    }
    
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
