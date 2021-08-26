//
//  Goal.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation
import SwiftUI

struct Goal: Codable, Identifiable {
    
    let id: Int
    let deviceId: String
    let content: String
    let completed: Bool
    let createdAt: String
    let category: Category
}

struct Goalpost: Codable {
    let deviceId: String
    var content: String
    var categoryId: Int
}

struct CurrentGoal: Codable {
    var id: Int
    var content: String?
    var status: Bool?
    var categoryName: String
}



