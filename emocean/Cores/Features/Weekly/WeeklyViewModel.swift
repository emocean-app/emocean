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
    @Published var categorySelected: Int = 0
    @Published var categories: [Category] = []
    @Published var selectedTabIndex: Int = 0
    // REPOS
    private var categoryRepo = CategoryRepository()
    private var checkinRepo = CheckinRepository()
    private var cancellable = Set<AnyCancellable>()
    // MARK: INIT
    init() {
        // Set dummy data as default
        currentStep = steps[0]
        categories = categoryRepo.getAllDummy()
        fetchData()
    }
}

// MARK: - NETWORKING METHODS
extension WeeklyViewModel {
    /// Get all categories from server
    func getAllCategories() {
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
    }
    /// Fetch all data needed from server
    func fetchData() {
        getAllCategories()
    }
}

// MARK: - VIEW METHODS
// MARK: NAVIGATION
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

// MARK: CATEGORIES
extension WeeklyViewModel {
    // MARK: CATEGORY
    /// Get category item status curently selected or not
    /// - Parameter model: a Category
    /// - Returns: a Bool wether it's already in checkin.categories or not
    func checkIfSelected(model: Category) -> Bool {
        let id = model.id
        return categorySelected == id
    }
    /// Handle the category button tapped gesture
    /// - Parameter model: an object of Category from the tapped button in view
    func categoryClicked(model: Category) {
        let id = model.id
        if categorySelected == id {
            categorySelected = 0
        } else {
            categorySelected = id
        }
    }
}
