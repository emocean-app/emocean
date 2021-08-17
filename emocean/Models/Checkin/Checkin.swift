//
//  Checkin.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation
struct Checkin: Codable {
    var deviceId: String = ""
    var moodId: Int
    var categoriesId: Int
    var stories: [Feedback]
}
