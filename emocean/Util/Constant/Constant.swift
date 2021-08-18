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
}
