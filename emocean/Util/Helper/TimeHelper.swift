//
//  TimeHelper.swift
//  emocean
//
//  Created by Farrel Anshary on 03/08/21.
//

import Foundation
import SwiftUI

enum TimeRange: String, CaseIterable {
    case morning = "Morning"
    case noon = "Noon"
    case sunset = "Sunset"
    case night = "Night"
}

struct Time {
    var timeRange: TimeRange

    init(_ currentTime: Date = Date()) {
        let calendar = Calendar(identifier: .gregorian)

        let hour = calendar.component(.hour, from: currentTime)
        if hour >= 19 || hour < 5 {
            self.timeRange = .night
        } else if hour < 11 {
            self.timeRange = .morning

        } else if hour < 15 {
            self.timeRange = .noon

        } else {
            self.timeRange = .sunset
        }
    }
    
    init(_ currentTime: DateComponents) {
        guard let hour = currentTime.hour else {
            self.timeRange = .night
            return
        }
        
        if hour >= 19 || hour < 5 {
            self.timeRange = .night
        } else if hour < 11 {
            self.timeRange = .morning

        } else if hour < 15 {
            self.timeRange = .noon

        } else {
            self.timeRange = .sunset
        }
    }

    func getSkyAnimation() -> String {
        switch timeRange {
        case .morning:
            return "AnimasiHomepagePagi"
        case .noon:
            return "AnimasiHomepageSiang"
        case .sunset:
            return "AnimasiHomepageSore"
        case .night:
            return "AnimasiHomepageMalam"
        }
    }

    func getRawValue() -> String {
        return timeRange.rawValue
    }

    func getMode() -> ColorScheme {
        return timeRange == .night ? .dark : .light
    }

    static func parseFromIso8601(from dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return formatter.date(from: dateString) ?? Date()
    }

    static func formatter(dateFormat: String, from date: DateComponents) -> String {
        let date = Calendar.current.date(from: date)

        guard let dateUnwrap = date else { return "" }

        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat

        return formatter.string(from: dateUnwrap)
    }

    static func formatter(dateFormat: String, from date: Date) -> String {
        let dateComponent = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date)
        return formatter(dateFormat: dateFormat, from: dateComponent)
    }
}
