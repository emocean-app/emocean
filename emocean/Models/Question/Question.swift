//
//  Question.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation

struct Questions: Codable {
    let id: Int
    let question: String
}

enum QuestionType: Int, Codable {
    case observation
    case description
}
