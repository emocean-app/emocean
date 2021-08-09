//
//  Checkin.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation
struct Checkin: Codable {
    var idmood: Int
    var categoriesId: Int
    var feedbacks: [Feedback]
}
