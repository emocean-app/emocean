//
//  CategoryRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

struct CategoryRepository: Repository {
    // Type
    typealias Entity = Category
    // PROPERTIES
    private var staticStore = SeederStaticCategory()
    private var networkStore = SeederNetworkingCategory()
    private var cancellables = Set<AnyCancellable>()
    // METHODS
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {
        return networkStore
            .getAllCategory()
            .map({ data -> [Entity] in
                return data.categories
            })
            .eraseToAnyPublisher()
    }
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
