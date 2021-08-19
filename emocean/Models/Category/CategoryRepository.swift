//
//  CategoryRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

struct CategoryRepository: Repository {
    // MARK: Type
    typealias Entity = Category
    // MARK: PROPERTIES
    private var staticStore = SeederStaticCategory()
    private var networkStore = SeederNetworkingCategory()
    private var cancellables = Set<AnyCancellable>()
    // MARK: METHODS
    /// Get all data from server
    /// - Returns: A Publisher
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError> {
        return networkStore
            .getAllCategory()
            .map({ data -> [Entity] in
                return data.categories
            })
            .eraseToAnyPublisher()
    }
    /// Get all dummy data
    /// - Returns: An array of Entity
    func getAllDummy() -> [Entity] {
        return staticStore.getData()
    }
}
