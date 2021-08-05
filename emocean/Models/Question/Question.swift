//
//  Question.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import Foundation

struct Questions: Codable{
    let id: Int
    let question: String
    let questiontype: QuestionType
    let prevquestion: Int
}

enum QuestionType: Int, Codable {
    case observation
    case description
}
