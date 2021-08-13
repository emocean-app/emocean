//
//  CheckinViewModel.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//
import Foundation
import SwiftUI
import Combine

class CheckinViewModel: ObservableObject {
    
    // MARK: PROPERTIES
    // Dummy
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
                "Please, tell me what made you feel $?"
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
                "Why does a $ make you feel that way?"
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
    // View
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    // Published
    @Published var currentStep: Step = CheckinViewModel.dummy[0]
    @Published var checkin = Checkin(
        idmood: 0,
        categoriesId: 0,
        feedbacks: []
    )
    @Published var moods: [Mood] = []
    @Published var categories: [Category] = []
    // others
    private var moodRepo = MoodRepository()
    private var categoryRepo = CategoryRepository()
    private var cancellable = Set<AnyCancellable>()
    // MARK: INIT
    init() {
        moods = moodRepo.getAllDummy()
        categories = categoryRepo.getAllDummy()
        fetchData()
    }
}

// MARK: - METHODS
extension CheckinViewModel {
    /// Fetch all data needed from server
    func fetchData() {
        // Moods
        moodRepo.getAllData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "")
                    guard let self = self else {return}
                    self.moods = self.moodRepo.getAllDummy()
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] data in
                self?.moods = data
            }
            .store(in: &cancellable)
        // Categories
        categoryRepo
            .getAllData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                    guard let self = self else {return}
                    self.categories = self.categoryRepo.getAllDummy()
                case .finished:
                    print("Finish")
                }
            } receiveValue: { [weak self] data in
                self?.categories = data
            }
            .store(in: &cancellable)
    }
    /// Get the coral alignment for background animation
    /// - Returns: an Alignment
    func getCoralAlignment() -> Alignment {
        if currentStep.viewType == .feelings {
            return .leading
        }
        return .center
    }
    /// Get the coral width for background animation
    /// - Returns: return a CGFloat of width
    func getCoralWidth() -> CGFloat {
        if currentStep.viewType == .observation {
            return UIScreen.main.bounds.width
        }
        return imageFullWidth
    }
    /// Get the coral width for background animation
    /// - Returns: return a CGFloat of width
    func getCoralHeight(isFront: Bool) -> CGFloat {
        if currentStep.viewType == .observation {
            return UIScreen.main.bounds.height * 0.2
        }    
        if isFront {
            return 300
        } else {
            return 275
        }
    }
    /// Change the checkin step forward
    /// - Parameter isYes: whether it's a NO or YES selection
    func goToNextStep(isYes: Bool) {
        guard let stepYes = CheckinViewModel.dummy.first(where: { $0.id == currentStep.nextYes }) else { return }
        guard let stepNo = CheckinViewModel.dummy.first(where: { $0.id == currentStep.nextNo }) else { return }
        currentStep = isYes ? stepYes : stepNo
    }
    /// Get category item status curently selected or not
    /// - Parameter model: a Category
    /// - Returns: a Bool wether it's already in checkin.categories or not
    func checkIfSelected(model: Category) -> Bool {
        let id = model.id
        return checkin.categoriesId == id
    }
    /// Handle the category button tapped gesture
    /// - Parameter model: an object of Category from the tapped button in view
    func categoryClicked(model: Category) {
        let id = model.id
        if checkin.categoriesId == id {
            checkin.categoriesId = 0
        } else {
            checkin.categoriesId = id
        }
    }
    /// Get the question for checkins
    /// - Returns: a String of question
    func getQuestion() -> String {
        if currentStep.question.id == 4 {
            guard let idx = categories.firstIndex(where: {$0.id == checkin.categoriesId}) else {return ""}
            let categoryName = categories[idx].name
            switch checkin.categoriesId {
            case 1...14:
                let question = currentStep.question.texts[0]
                return question.replacingOccurrences(of: "$", with: categoryName)
            case 19...24:
                let question = currentStep.question.texts[1]
                return question.replacingOccurrences(of: "$", with: categoryName)
            case 15...16:
                let question = currentStep.question.texts[2]
                return question.replacingOccurrences(of: "$", with: categoryName)
            case 17...18:
                let question = currentStep.question.texts[3]
                return question.replacingOccurrences(of: "$", with: categoryName)
            default:
                return ""
            }
        }
        return currentStep.question.texts[0]
    }
    /// Save the feedback answers
    /// - Parameter answer: string of answer 
    func saveFeedback(answer: String) {
        let questionId = currentStep.question.id
        let feedback = Feedback(idquestion: questionId, answer: answer)
        checkin.feedbacks.append(feedback)
    }
    func getMood(energy: Int, pleasent: Int) -> Mood? {
        guard let mood = moods.first(where: {$0.energy == energy && $0.pleasent == pleasent }) else { return nil }
        return mood
    }
    func getMoodDescription(energy: Int, pleasent: Int) -> String {
        return getMood(energy: energy, pleasent: pleasent)?.description ?? ""
    }
    func getMoodName(energy: Int, pleasent: Int) -> String {
        return getMood(energy: energy, pleasent: pleasent)?.name ?? "Neutral"
    }
    func getMoodImage(energy: Int, pleasent: Int) -> String {
        return getMood(energy: energy, pleasent: pleasent)?.imageUrl ?? "Placeholder"
    }
    func getMoodImage() -> String {
        let mood = moods.first(where: {$0.id == checkin.idmood})
        return mood?.imageUrl ?? "BuntelDua"
    }
    func getMoodName() -> String {
        let mood = moods.first(where: {$0.id == checkin.idmood})
        return mood?.name ?? "Neutral"
    }
    func setMood(mood: Mood) {
        checkin.idmood = mood.id
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
