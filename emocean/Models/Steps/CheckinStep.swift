//
//  CheckinStep.swift
//  emocean
//
//  Created by Puras Handharmahua on 17/08/21.
//

import Foundation

struct CheckinStep {
    let id: Int
    let viewType: CheckinScreenState
    var questions: [Question]
    let next: Int
    let sequencePrompt: String
    let text: String?
    var totalQuestion: Int {
        return questions.count
    }
    var isSentiment: Bool {
        guard totalQuestion > 0,
              questions[0].type != nil else {
            return false
        }
        return true
    }
}

enum CheckinScreenState {
    case feelings
    case description
    case observation
    case category
    case succes
}
