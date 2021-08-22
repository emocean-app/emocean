//
//  WeeklyCheckinStep.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import Foundation

protocol WeeklyCheckinStep {
    var id: Int {get}
    var viewType: WeeklyCheckinScreenState { get }
    var backgroundType: WeeklyBackgroundState { get }
    var next: Int {get}
}

// Model for Primary Screen Type
struct PrimaryWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .primary
    var backgroundType: WeeklyBackgroundState = .bubble
    var next: Int
}

// Model for Secondary Screen Type
struct SecondaryWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .secondary
    var backgroundType: WeeklyBackgroundState = .sky
    var next: Int
    var question: String
}

// Model for Third Screen Type
struct ThirdWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .third
    var backgroundType: WeeklyBackgroundState
    var next: Int
    var nextSecondary: Int
    var text: String
    var selection: Bool = true
}

// Model for Fourth Screen Type
struct FourthWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .fourth
    var backgroundType: WeeklyBackgroundState = .sky
    var next: Int
}

// Model for Fifth Screen Type
struct FifthWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .fifth
    var backgroundType: WeeklyBackgroundState = .scenery
    var next: Int
    var nextSecondary: Int
}

// Model for Sixth Screen Type
struct SixthWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .sixth
    var backgroundType: WeeklyBackgroundState = .scenery
    var next: Int
}

// Weekly Checkin Pages Type
enum WeeklyCheckinScreenState {
    case primary // 1
    case secondary // 2, 6, 10
    case third // 3, 4, 9, 8?
    case fourth // 5
    case fifth // 7
    case sixth // 11
}

enum WeeklyBackgroundState: String {
    case bubble
    case scenery
    case sky
}
