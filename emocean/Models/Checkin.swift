//
//  Checkin.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation
struct Checkin: Codable {
    let idmood: Int
    let categories: [Category]
    let elaborated: Bool
    let enjoyed: Bool
    let feedbacks: [Feedback]
}
