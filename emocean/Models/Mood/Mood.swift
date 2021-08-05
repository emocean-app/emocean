//
//  Mood.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation
struct Mood: Codable {
    let name: String
    let description: String
    let image: String
    let energy: Int
    let pleasent: Int
}
