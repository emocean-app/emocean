//
//  WeeklyCheckinStep.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import Foundation

protocol WeeklyCheckinStep {
    var id: Int {get}
    var viewType: WeeklyCheckinScreenState {get}
    var next: Int {get}
}

struct PrimaryWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .primary
    var next: Int
}

struct SecondaryWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .secondary
    var next: Int
    var question: String
}

struct ThirdWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .third
    var next: Int
    var nextSecondary: Int
    var text: String
    var selection: Bool = true
}

struct FourthWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .fourth
    var next: Int
}

struct FifthWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .fifth
    var next: Int
    var nextSecondary: Int
}

struct SixthWeeklyCheckinStep: WeeklyCheckinStep {
    var id: Int
    var viewType: WeeklyCheckinScreenState = .sixth
    var next: Int
}

enum WeeklyCheckinScreenState {
    case primary // 1
    case secondary // 2, 6, 10
    case third // 3, 4, 9, 8?
    case fourth // 5
    case fifth // 7
    case sixth // 11
}
