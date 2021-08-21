//
//  WeeklyViewModel.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import Foundation
import Combine
import SwiftUI

class WeeklyViewModel: ObservableObject {
    // MARK: PROPERTIES
    // VIEW
    private var steps: [WeeklyCheckinStep] = {
        return Constant.WeeklyCheckinSteps
    }()
    // PUBLISHED
    @Published var currentStep: WeeklyCheckinStep = {
        return Constant.WeeklyCheckinSteps[0]
    }()
    @Published var checkin = Checkin(
        deviceId: "\(UIDevice.current.identifierForVendor?.uuidString ?? "simulator")",
        moodId: 0,
        categoryId: 0,
        stories: []
    )
    @Published var categories: [Category] = []
    // REPOS
    private var categoryRepo = CategoryRepository()
    private var checkinRepo = CheckinRepository()
    private var questionRepo = QuestionRepository()
    private var cancellable = Set<AnyCancellable>()
    // MARK: INIT
    init() {
        // Set dummy data as default
        categories = categoryRepo.getAllDummy()
//        fetchData()
    }
}

// MARK: - VIEW METHODS

extension WeeklyViewModel {
    func getBackground() -> WeeklyBackgroundState {
        return currentStep.backgroundType
    }
    func getScreenState() -> WeeklyCheckinScreenState {
        return currentStep.viewType
    }
}
