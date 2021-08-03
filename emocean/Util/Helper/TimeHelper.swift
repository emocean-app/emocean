//
//  TimeHelper.swift
//  emocean
//
//  Created by Farrel Anshary on 03/08/21.
//

import Foundation

enum TimeRange: String {
    case morning = "Morning"
    case noon = "Noon"
    case sunset = "Sunset"
    case night = "Night"
}

struct Time {
    var timeRange: TimeRange
    
    init() {
        let calendar = Calendar(identifier: .gregorian)
        let currentTime = Date()
        
        let hour = calendar.component(.hour, from: currentTime)
        if hour < 11 { self.timeRange = .morning }
        else if hour < 15 { self.timeRange = .noon}
        else if hour < 19 { self.timeRange = .sunset }
        else { self.timeRange = .night }
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
}
