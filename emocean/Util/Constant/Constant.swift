//
//  Constant.swift
//  emocean
//
//  Created by Puras Handharmahua on 04/08/21.
//
import Foundation

struct Constant {
    static let baseUrl = "https://emocean.me/"
    static let CheckinSteps = [
        CheckinStep(
            id: 1,
            viewType: .feelings,
            questions: [],
            next: 2,
            sequencePrompt: "0",
            text: "How do you feel?"
        ),
        CheckinStep(
            id: 2,
            viewType: .category,
            questions: [],
            next: 3,
            sequencePrompt: "0",
            text: "What is this emotion related to?"
        ),
        CheckinStep(
            id: 3,
            viewType: .observation,
            questions: [],
            next: 4,
            sequencePrompt: "0",
            text: nil
        ),
        CheckinStep(
            id: 4,
            viewType: .description,
            questions: [],
            next: 5,
            sequencePrompt: "1",
            text: nil
        ),
        CheckinStep(
            id: 5,
            viewType: .description,
            questions: [],
            next: 6,
            sequencePrompt: "2",
            text: nil
        ),
        CheckinStep(
            id: 6,
            viewType: .succes,
            questions: [],
            next: 0,
            sequencePrompt: "3",
            text: nil
        )
    ]
    static let WeeklyCheckinSteps: [WeeklyCheckinStep] = [
        PrimaryWeeklyCheckinStep(id: 1, next: 2), // 1
        SecondaryWeeklyCheckinStep(
            id: 2,
            next: 3,
            question: "Why do you think this pattern occur in your week?"
        ), // 2
        ThirdWeeklyCheckinStep(
            id: 3,
            backgroundType: .sky,
            next: 10,
            nextSecondary: 4,
            text: "Are you comfortable with this\npattern that's happening to you?"
        ), // 3
        ThirdWeeklyCheckinStep(
            id: 4,
            backgroundType: .sky,
            next: 5,
            nextSecondary: 11,
            text: "Are there things you can\nchange to make you feel more\ncomfortable?"
        ), // 4
        FourthWeeklyCheckinStep(id: 5, next: 6), // 5
        SecondaryWeeklyCheckinStep(
            id: 6,
            next: 7,
            question: "What change do you want to make?"
        ), // 6
        FifthWeeklyCheckinStep(id: 7, next: 8, nextSecondary: 9), // 7
        ThirdWeeklyCheckinStep(
            id: 8,
            backgroundType: .scenery,
            next: 0,
            nextSecondary: 0,
            text: "You've achieved your goal, keep the spirit for the next week!",
            selection: false
        ), // 8
        ThirdWeeklyCheckinStep(
            id: 9,
            backgroundType: .scenery,
            next: 0,
            nextSecondary: 0,
            text: "Do you want to keep\non your goal?"
        ), // 9
        SecondaryWeeklyCheckinStep(
            id: 10,
            next: 7,
            question: "What do you want to do to keep this pattern?"
        ), // 10
        SixthWeeklyCheckinStep(id: 11, next: 0)
    ]
}
