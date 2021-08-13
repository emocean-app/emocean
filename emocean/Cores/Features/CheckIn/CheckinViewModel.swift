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
    static let steps: [Step] = [
        Step(id: 1,
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
            question: DummQuestion(id: 2, texts: [
                "What is this emotion related to?"
            ]),
            nextYes: 3,
            nextNo: 3,
            totalQuestion: 1
        ),
        Step(
            id: 3,
            viewType: .observation,
            question:  DummQuestion(id: 3, texts: [
                ""
            ]),
            nextYes: 4,
            nextNo: 4,
            totalQuestion: 1
        ),
        Step(
            id: 4,
            viewType: .description,
            question:  DummQuestion(id: 4, texts: [
                "Tell me what’s happening inside you that's causing this emotion?",
                "Why do you feel this way?",
                "What could possibly happening inside yourself?",
                "Does this emotion seem to repeat in your life and why?"
            ]),
            nextYes: 5,
            nextNo: 5,
            totalQuestion: 1
        ),
        Step(
            id: 5,
            viewType: .description,
            question:  DummQuestion(id: 5, texts: [
                "What do you need to feel better?",
                "What is it that you truly want?",
                "What do you need to mantain this state of mind?"
            ]),
            nextYes: 6,
            nextNo: 6,
            totalQuestion: 1
        ),
        Step(
            id: 6,
            viewType: .succes,
            question:  DummQuestion(id: 6, texts: [
                "Thank you for showing this part of you",
                "Thank you for the courage to tell yourself what you feel",
                "Thank you for giving yourself the time to reflect on yourself"
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
    @Published var currentStep: Step = CheckinViewModel.steps[0]
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
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var timerCancellable: AnyCancellable?
    private var sec = 0.0
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
        guard let stepYes = CheckinViewModel.steps.first(where: { $0.id == currentStep.nextYes }) else { return }
        guard let stepNo = CheckinViewModel.steps.first(where: { $0.id == currentStep.nextNo }) else { return }
        currentStep = isYes ? stepYes : stepNo
        print(currentStep.id)
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
        return currentStep.question.texts[0]
    }
    /// Save the feedback answers
    /// - Parameter answer: string of answer 
    func saveFeedback(answer: String) {
        let questionId = currentStep.question.id
        let feedback = Feedback(idquestion: questionId, answer: answer)
        checkin.feedbacks.append(feedback)
    }
    /// Get the mood from the amount of energy and pleasentness
    /// - Parameters:
    ///   - energy: amount of energy - CGFloat
    ///   - pleasent: amount of pleasentness - CGFloat
    /// - Returns: an instance of Mood
    func getMood(energy: Int, pleasent: Int) -> Mood? {
        guard let mood = moods.first(where: {$0.energy == energy && $0.pleasent == pleasent }) else { return nil }
        return mood
    }
    /// Get the mood description from the amount of energy and pleasentness
    /// - Parameters:
    ///   - energy: amount of energy - CGFloat
    ///   - pleasent: amount of pleasentness - CGFloat
    /// - Returns: String of description
    func getMoodDescription(energy: Int, pleasent: Int) -> String {
        return getMood(energy: energy, pleasent: pleasent)?.description ??
            "Slide the bar below according to how you feel right now"
    }
    /// Get the mood name from the amount of energy and pleasentness
    /// - Parameters:
    ///   - energy: amount of energy - CGFloat
    ///   - pleasent: amount of pleasentness - CGFloat
    /// - Returns: String of name
    func getMoodName(energy: Int, pleasent: Int) -> String {
        return getMood(energy: energy, pleasent: pleasent)?.name ?? ""
    }
    /// Get the mood image path from the amount of energy and pleasentness
    /// - Parameters:
    ///   - energy: amount of energy - CGFloat
    ///   - pleasent: amount of pleasentness - CGFloat
    /// - Returns: String of image path
    func getMoodImage(energy: Int, pleasent: Int) -> String {
        return getMood(energy: energy, pleasent: pleasent)?.imageUrl ?? "Placeholder"
    }
    /// Get the mood image path from the amount of energy and pleasentness
    /// - Returns: String of image path
    func getMoodImage() -> String {
        let mood = moods.first(where: {$0.id == checkin.idmood})
        return mood?.imageUrl ?? "BuntelDua"
    }
    /// Get the mood name from the amount of energy and pleasentness
    /// - Returns: String of mood's name
    func getMoodName() -> String {
        let mood = moods.first(where: {$0.id == checkin.idmood})
        return mood?.name ?? "Neutral"
    }
    /// Set the mood in for checkin
    /// - Parameter mood: an instance of mood
    func setMood(mood: Mood) {
        checkin.idmood = mood.id
    }
    /// Start Timer to go to next step
    func startTimer() {
        timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        timerCancellable = timer?
            .sink(receiveValue: { [weak self] _ in
            guard let self = self else {return}
            if self.sec == Double(1.5) {
                self.sec = 0.0
                self.timer = nil
                withAnimation(.easeInOut(duration: 1)) {
                    self.goToNextStep(isYes: true)
                }
                self.timerCancellable?.cancel()
            } else {
                self.sec += 0.5
            }
        })
    }
    /// Get the next step screen type
    /// - Returns: enum of screen type or nil
    func nextStepType() -> ScreenState? {
        guard let nextStep = CheckinViewModel.steps.first(where: { $0.id == currentStep.nextYes }) else {return nil}
        return nextStep.viewType
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
