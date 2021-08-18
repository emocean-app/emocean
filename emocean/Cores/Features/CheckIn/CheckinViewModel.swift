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
    // View
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var timerCancellable: AnyCancellable?
    private var sec = 0.0
    private var activePrompt: Question?
    // Published
    private var steps: [CheckinStep] = []
    @Published var currentStep: CheckinStep
    @Published var checkin = Checkin(
        deviceId: "\(UIDevice.current.identifierForVendor?.uuidString ?? "simulator")",
        moodId: 0,
        categoryId: 0,
        stories: []
    )
    @Published var moods: [Mood] = []
    @Published var categories: [Category] = []
    // Repos
    private var moodRepo = MoodRepository()
    private var categoryRepo = CategoryRepository()
    private var checkinRepo = CheckinRepository()
    private var questionRepo = QuestionRepository()
    private var cancellable = Set<AnyCancellable>()
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var timerCancellable: AnyCancellable?
    private var isfirst: Bool = true
    private var sec = 0.0
    private var postResponse = ""
    // MARK: INIT
    init() {
        moods = moodRepo.getAllDummy()
        categories = categoryRepo.getAllDummy()
        steps = Constant.CheckinSteps
        currentStep = steps[0]
        fetchData()
    }
}

// MARK: - NETWORKING METHODS

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
                    print("Finish get all moods")
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
                    print("Finish get all categories")
                }
            } receiveValue: { [weak self] data in
                self?.categories = data
            }
            .store(in: &cancellable)
        // Steps
        questionRepo
            .getAllData()
            .sink { [weak self] completion in
                guard let self = self else {return}
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "ERROR")
                    self.currentStep = self.steps[0]
                case .finished:
                    print("Finish get all questions")
                    self.currentStep = self.steps[0]
                }
            } receiveValue: { [weak self] val in
                self?.steps = val
            }
            .store(in: &cancellable)
    }
    /// Add Checkin to the server
    func addCheckin() {
        checkinRepo
            .postData(body: checkin)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                case .finished:
                    print("Finsihed post checkin")
//                    print(self?.postResponse)
                }
            } receiveValue: { [weak self] data in
                self?.postResponse = data
            }
            .store(in: &cancellable)
    }
}

// MARK: - UI METHODS
extension CheckinViewModel {
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
    func goToNextStep() {
        guard let next = steps.first(where: { $0.id == currentStep.next }) else { return }
        currentStep = next
        // Select The Question
        guard currentStep.text == nil,
              currentStep.totalQuestion > 0 else { return }
        if currentStep.isSentiment {
            guard let mood = getMood() else { return }
            let questionArr = currentStep.questions.filter({ $0.type! == mood.moodType })
            let randomInt = Int.random(in: 0..<questionArr.count)
            activePrompt = questionArr[randomInt]
        } else {
            let randomInt = Int.random(in: 0..<currentStep.totalQuestion)
            activePrompt = currentStep.questions[randomInt]
        }
    }
    /// Get category item status curently selected or not
    /// - Parameter model: a Category
    /// - Returns: a Bool wether it's already in checkin.categories or not
    func checkIfSelected(model: Category) -> Bool {
        let id = model.id
        return checkin.categoryId == id
    }
    /// Handle the category button tapped gesture
    /// - Parameter model: an object of Category from the tapped button in view
    func categoryClicked(model: Category) {
        let id = model.id
        if checkin.categoryId == id {
            checkin.categoryId = 0
        } else {
            checkin.categoryId = id
        }
    }
    /// Get the question for checkins
    /// - Returns: a String of question
    func getQuestion() -> String {
        if currentStep.text != nil {
            return currentStep.text!
        }
        guard let prompt = activePrompt else {return ""}
        return prompt.question
    }
    /// Get the static question/prompt for checkin
    /// - Returns: String of question
    func getStaticQuestion() -> String {
        guard let text = currentStep.text else {return ""}
        return text
    }
    /// Save the feedback answers
    /// - Parameter answer: string of answer
    func saveFeedback(answer: String) {
        guard let prompt = activePrompt else {return}
        let questionId = prompt.id
        let feedback = Feedback(questionId: questionId, story: answer)
        checkin.stories.append(feedback)
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
    /// Get the current selected mood
    /// - Returns: an instance of Mood
    func getMood() -> Mood? {
        guard let mood = moods.first(where: {$0.id == checkin.moodId}) else {return nil}
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
        let mood = moods.first(where: {$0.id == checkin.moodId})
        return mood?.imageUrl ?? "BuntelDua"
    }
    /// Get the mood name from the amount of energy and pleasentness
    /// - Returns: String of mood's name
    func getMoodName() -> String {
        let mood = moods.first(where: {$0.id == checkin.moodId})
        return mood?.name ?? "Neutral"
    }
    /// Set the mood in for checkin
    /// - Parameter mood: an instance of mood
    func setMood(mood: Mood) {
        checkin.moodId = mood.id
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
                    self.goToNextStep()
                }
                self.timerCancellable?.cancel()
            } else {
                self.sec += 0.5
            }
        })
    }
    /// Get the next step screen type
    /// - Returns: enum of screen type or nil
    func nextStepType() -> CheckinScreenState? {
        guard let nextStep = steps.first(where: { $0.id == currentStep.next }) else {return nil}
        return nextStep.viewType
    }
}
