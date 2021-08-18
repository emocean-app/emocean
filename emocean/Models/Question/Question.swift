//
//  Question.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation

struct Question: Codable {
    let id: Int
    let question: String
    let sequence: Int
    let type: String?
}

enum QuestionType: Int, Codable {
    case observation
    case description
}
