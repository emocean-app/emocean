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
    var categoryId: Int
    var stories: [Feedback]
    var period: CheckinPeriod
}

enum CheckinPeriod: String, Codable {
    case daily
    case weekly
    case monthly
    case yearly
}
