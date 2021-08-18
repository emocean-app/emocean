//
//  Goal.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation

struct Goal: Codable, Identifiable {
    var id: String = UUID().uuidString
    let goal: String
    let category: String
    let date: String
    let status: Bool
}
