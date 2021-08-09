//
//  Mood.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation

struct Mood: Identifiable, Codable {
    
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    let energy: Int
    let pleasent: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageUrl = "image_url"
        case energy
        case pleasent
    }
}
/*
 {
     "id": 1,
     "name": "Despairing",
     "description": "Feeling extreme dislike or disapproval of something",
     "image_url": "ArwanaDua",
     "energy": 1,
     "pleasent": 1
 },
 */
