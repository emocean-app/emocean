//
//  Category.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//
import Foundation

struct Category: Codable {
    let id: Int
    let name: String
}

struct CategorySelection {
    let id: Int
    let name: String
    var isSelected: Bool
    
    init(category: Category) {
        self.id = category.id
        self.name = category.name
        self.isSelected = false
    }
}
