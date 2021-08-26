//
//  SeederStaticQuestion.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation

struct SeederStaticQuestion {
    /// Get all questions for checkin
    /// - Returns: Dictionary of Questions with section as key
    func getAllQuestion() -> [String : [Question]] {
        return [
            "1" : [
                Question(
                    id: 1,
                    question: "Tell me what’s happening inside you that's causing this emotion?",
                    sequence: 1,
                    type: nil
                )
            ],
            "2" : [
                Question(
                    id: 5,
                    question: "What do you need to feel better?",
                    sequence: 2,
                    type: "NEGATIVE"
                ),
                Question(
                    id: 7,
                    question: "What do you need to mantain this state of mind?",
                    sequence: 2,
                    type: "POSITIVE"
                )
            ],
            "3" : [
                Question(
                    id: 8,
                    question: "Thank you for showing this part of you",
                    sequence: 3,
                    type: nil
                )
            ]
        ]
    }
}
