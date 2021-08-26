//
//  MainViewModel.swift
//  emocean
//
//  Created by Farrel Anshary on 25/08/21.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    private var cancellable = Set<AnyCancellable>()
    private var goalRepo = GoalRepository()
    private var progressRepo = ProgressRepository()
    
    @Published var goals = [Goal]()
    @Published var progress: Progress?
    @Published var progressCount = [String: Int]()

    init() {
        getProgress()
        getGoals()
    }

    // MARK: - NETWORKING METHODS
    func getGoals() {
        goalRepo
            .getAllData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "")
                    guard let self = self else { return }
                    self.goals = self.goalRepo.getAllDummy()
                case .finished:
                    print("Finish get all goals")
                }
            } receiveValue: { [weak self] data in
                self?.goals = data
            }
            .store(in: &cancellable)
    }

    func getProgress() {
        progressRepo
            .getData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "")
                    guard let self = self else { return }
                    self.progress = nil
                case .finished:
                    print("Finish get progress")
                }
            } receiveValue: { [weak self] data in
                print(data)
                self?.progress = data
                self?.mapQuadrant()
            }
            .store(in: &cancellable)
    }

    func mapQuadrant() {
        guard let progress = progress else { return }

        for quadrant in progress.progress {
            progressCount[quadrant.quadrant] = quadrant.count
        }
    }
}
