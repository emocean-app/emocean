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
    @Published var currentStep: WeeklyCheckinStep
    @Published var checkin = Checkin(
        deviceId: "\(UIDevice.current.identifierForVendor?.uuidString ?? "simulator")",
        moodId: 0,
        categoryId: 0,
        stories: []
    )
    @Published var categories: [Category] = []
    @Published var selectedTabIndex: Int = 0
    // REPOS
    private var categoryRepo = CategoryRepository()
    private var checkinRepo = CheckinRepository()
    private var questionRepo = QuestionRepository()
    private var cancellable = Set<AnyCancellable>()
    // MARK: INIT
    init() {
        // Set dummy data as default
        currentStep = steps[0]
        categories = categoryRepo.getAllDummy()
//        fetchData()
    }
}

// MARK: - NETWORKING METHODS

// MARK: - VIEW METHODS
// NAVIGATION
extension WeeklyViewModel {
    /// Get the background type of current step
    /// - Returns: Enum of WeeklyBackgroundState
    func getBackground() -> WeeklyBackgroundState {
        return currentStep.backgroundType
    }
    /// Get the view type of current step
    /// - Returns: Enum of WeeklyCheckinScreenState
    func getScreenState() -> WeeklyCheckinScreenState {
        return currentStep.viewType
    }
    /// Go to the next step
    /// - Parameter id: Int id of the next step
    func goToNextStep(id: Int) {
        guard let step = steps.first(where: { $0.id == id }) else {return}
        currentStep = step
    }
}
