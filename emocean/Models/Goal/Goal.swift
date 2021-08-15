//
//  Goal.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation

struct Goal: Codable, Identifiable {
    
    let id: Int
    let goal: String
    let category: String
    let date: String
    let status: Bool
    
}
