//
//  Repository.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation
import Combine

protocol Repository {
    associatedtype Entity: Codable
    
    func getAllData() -> AnyPublisher<[Entity], NetworkRequestError>
}
