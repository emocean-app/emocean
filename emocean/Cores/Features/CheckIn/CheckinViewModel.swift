//
//  CheckinViewModel.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//
import Foundation
import SwiftUI

class CheckinViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    static let dummy: [Step] = [
        Step(
            id: 1,
            viewType: .feelings,
            question: DummQuestion(id: 1, texts: [
                "How do you feel?"
            ]),
            nextYes: 2,
            nextNo: 2,
            totalQuestion: 1
        ),
        Step(
            id: 2,
            viewType: .category,
            question: DummQuestion(id: 1, texts: [
                "How do you feel?"
            ]),
            nextYes: 3,
            nextNo: 3,
            totalQuestion: 1
        ),
        Step(
            id: 3,
            viewType: .observation,
            question:  DummQuestion(id: 3, texts: [
                "Would you like to elaborate on this?"
            ]),
            nextYes: 4,
            nextNo: 5,
            totalQuestion: 1
        ),
        Step(
            id: 4,
            viewType: .description,
            question:  DummQuestion(id: 4, texts: [
                "Can you tell me about how your $ are going lately?",
                "Can you tell me what's on your mind about your $?",
                "Can you tell me about what happened to the $?",
                
            ]),
            nextYes: 5,
            nextNo: 5,
            totalQuestion: 1
        ),
        Step(
            id: 5,
            viewType: .observation,
            question:  DummQuestion(id: 5, texts: [
                "Do you enjoy this feeling"
            ]),
            nextYes: 9,
            nextNo: 6,
            totalQuestion: 1
        ),
        Step(
            id: 6,
            viewType: .description,
            question:  DummQuestion(id: 6, texts: [
                "Are there anything happening that might be involved in this?",
                "What external factor that might trigger this feeling?",
                "Is there something that might be involved in this?"
            ]),
            nextYes: 7,
            nextNo: 7,
            totalQuestion: 1
        ),
        Step(
            id: 7,
            viewType: .prompt,
            question:  DummQuestion(id: 7, texts: [
                "Okay now focus on yourself",
                "Okay now take a deep breath",
                "Okay now empty your mind"
            ]),
            nextYes: 8,
            nextNo: 8,
            totalQuestion: 1
        ),
        Step(
            id: 8,
            viewType: .description,
            question:  DummQuestion(id: 8, texts: [
                "What do you need most right now?"
            ]),
            nextYes: 10,
            nextNo: 10,
            totalQuestion: 1
        ),
        Step(
            id: 9,
            viewType: .description,
            question:  DummQuestion(id: 9, texts: [
                "What can you do to maintain this things?"
            ]),
            nextYes: 10,
            nextNo: 10,
            totalQuestion: 1
        ),
        Step(
            id: 10,
            viewType: .succes,
            question:  DummQuestion(id: 9, texts: [
                "What can you do to maintain this things?"
            ]),
            nextYes: 0,
            nextNo: 0,
            totalQuestion: 0
        )
    ]
    
    static let dummQuest: [DummQuestion] = [
        DummQuestion(id: 1, texts: [
            "How do you feel?"
        ]),
        DummQuestion(id: 2, texts: [
            "Please, tell me what made you feel sad?"
        ]),
        DummQuestion(id: 3, texts: [
            "Would you like to elaborate on this?"
        ]),
        DummQuestion(id: 4, texts: [
            "Can you tell me about how your $ are going lately?",
            "Can you tell me what's on your mind about your $?",
            "Can you tell me about what happened to the $?",
            
        ]),
        DummQuestion(id: 5, texts: [
            "Do you enjoy this feeling"
        ]),
        DummQuestion(id: 6, texts: [
            "Are there anything happening that might be involved in this?",
            "What external factor that might trigger this feeling?",
            "Is there something that might be involved in this?"
        ]),
        DummQuestion(id: 7, texts: [
            "Okay now focus on yourself",
            "Okay now take a deep breath",
            "Okay now empty your mind"
        ]),
        DummQuestion(id: 8, texts: [
            "What do you need most right now?"
        ]),
        DummQuestion(id: 9, texts: [
            "What can you do to maintain this things?"
        ])
    ]
    
    // View
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    @Published var step: Int = 0
    @Published var currentStep: Step = CheckinViewModel.dummy[0]
}

// MARK: - METHODS
extension CheckinViewModel {
    func getCoralAlignment() -> Alignment {
        if currentStep.viewType == .feelings {
            return .leading
        }
        return .center
    }
    
    func getCoralWidth() -> CGFloat {
        
        if currentStep.viewType == .observation {
            return UIScreen.main.bounds.width
        }
        
        return imageFullWidth
    }
    
    func nextStep(index: Int) {
        step = index
    }
    
    func goToNextStep(isYes: Bool) {
        
        guard let stepYes = CheckinViewModel.dummy.first(where: { $0.id == currentStep.nextYes }) else { return }
        guard let stepNo = CheckinViewModel.dummy.first(where: { $0.id == currentStep.nextNo }) else { return }
        
        currentStep = isYes ? stepYes : stepNo
    }
}

// MARK: - ENUM & STRUCT
extension CheckinViewModel {
    
    enum ScreenState {
        case feelings
        case description
        case observation
        case category
        case succes
        case prompt
    }
    
    struct Step {
        let id: Int
        let viewType: ScreenState
        let question: DummQuestion
        let nextYes: Int
        let nextNo: Int
        let totalQuestion: Int
    }
    
    struct DummQuestion {
        let id: Int
        let texts: [String]
        var totalQuestion: Int {
            return texts.count
        }
    }
}
