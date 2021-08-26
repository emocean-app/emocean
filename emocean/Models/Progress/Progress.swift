//
//  Progress.swift
//  emocean
//
//  Created by Farrel Anshary on 25/08/21.
//

import Foundation

struct Progress: Codable {
    let progress: [Quadrant]
    let mood: Mood
    let total: Int
}

struct Quadrant: Codable {
    let quadrant: String
    let count: Int
}
