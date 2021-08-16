//
//  Goal.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation

struct Goal: Codable, Identifiable {
    
    let id: Int
    let content: String
    let category: String?
    let createdAt: String
    let completed: Bool
    
}
