//
//  QuestionRepository.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation
import Combine

struct QuestionRepository {
    // Type
    typealias Entity = Question
    // PROPERTIES
    private var staticStore = SeederStaticQuestion()
    private var networkStore = SeederNetworkingQuestion()
    private var cancellables = Set<AnyCancellable>()
    // METHODS
    func getAllData() -> AnyPublisher<[CheckinStep], NetworkRequestError> {
        return networkStore
            .getCheckinQuestion()
            .map({ data -> [CheckinStep] in
                let steps = getSteps(questions: data.questions)
                return steps
            })
            .eraseToAnyPublisher()
    }
    func getAllDummy() -> [String: [Entity]] {
        return staticStore.getAllQuestion()
    }
    private func getSteps(questions: [String: [Entity]]) -> [CheckinStep] {
        var steps = Constant.CheckinSteps
        // Looping the sequence
        for (key, value) in questions {
            guard let stepIdx = steps.firstIndex(where: { $0.sequencePrompt == key }) else { continue }
            steps[stepIdx].questions = value
        }
        return steps
    }
}
