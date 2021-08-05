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
    let dummy = [
        Step(type: .feelings, question: "", nextYes: 1, nextNo: nil), // 0
        Step(type: .category, question: "", nextYes: 2, nextNo: nil), // 1
        Step(type: .observation, question: "Would you like to elaborate on this?", nextYes: 3, nextNo: 4), // 2
        Step(type: .description, question: "Lorem ipsum dolor sit amet", nextYes: 5, nextNo: nil), // 3
        Step(type: .observation, question: "Do you enjoy this feeling?", nextYes: 8, nextNo: 5), // 4
        Step(type: .description, question: "Is there something happening that might be involved in this?", nextYes: 6, nextNo: nil), // 5
        Step(type: .description, question: "Lorem ipsum dolor sit amet", nextYes: 7, nextNo: nil), // 6
        Step(type: .description, question: "What do you need right now?", nextYes: 9, nextNo: nil), // 7
        Step(type: .description, question: "What can you do to maintain this thing?", nextYes: 9, nextNo: nil), // 8
        Step(type: .succes, question: "", nextYes: 0, nextNo: nil) // 9
    ]
    
    // View
    @Published var screenState: ScreenState = .feelings
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    @Published var step: Int = 0
    var currentStep: Step {
        return dummy[step]
    }
}

// MARK: - METHODS
extension CheckinViewModel {
    func getCoralAlignment() -> Alignment {
        if currentStep.type == .feelings {
            return .leading
        }
        return .center
    }
    
    func getCoralWidth() -> CGFloat {
        
        if currentStep.type == .observation {
            return UIScreen.main.bounds.width
        }
        
        return imageFullWidth
    }
    
    func nextStep(index: Int) {
        step = index
    }
}

// MARK: - ENUM
extension CheckinViewModel {
    
    enum ScreenState {
        case feelings
        case description
        case observation
        case category
        case succes
    }
    
    struct Step {
        let type: ScreenState
        let question: String
        let nextYes: Int
        let nextNo: Int?
    }
}
