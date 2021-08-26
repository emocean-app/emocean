//
//  HistoryViewModel.swift
//  emocean
//
//  Created by Farrel Anshary on 24/08/21.
//

import Foundation
import Combine
import UIKit

class HistoryViewModel: ObservableObject {
    // MARK: - PROPERTIES
    private var cancellable = Set<AnyCancellable>()
    private var historyRepo = HistoryRepository()

    @Published var selectedDate: DateComponents = {
        return Calendar.current.dateComponents([.day,.month,.year], from: Date())
    }()

    @Published var histories = [History]()

    var selectedDateString: String {
        formatter(dateFormat: "EEEE, MMM d yyyy", from: selectedDate)
    }

    private var params: [String: String] = [
        "deviceId": String(UIDevice.current.identifierForVendor!.uuidString)
    ]

    init() {
        setup()
    }
}

// MARK: - METHODS
extension HistoryViewModel {
    func formatter(dateFormat: String, from date: DateComponents) -> String {
        let date = Calendar.current.date(from: date)

        guard let dateUnwrap = date else { return "" }

        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        
        return formatter.string(from: dateUnwrap)
    }
}

// MARK: - NETWORKING METHODS
extension HistoryViewModel {
    func setup() {
        $selectedDate
            .sink { [weak self] date in
                self?.params["date"] = self?.formatter(dateFormat: "yyyy-MM-dd", from: date)
                self?.getHistory()
            }
            .store(in: &cancellable)
    }

    func getHistory() {
        historyRepo
            .getData(params: params)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "")
                    guard let self = self else { return }
                    self.histories = self.historyRepo.getDummy()
                case .finished:
                    print("Finish get all history")
                }
            } receiveValue: { [weak self] data in
                self?.histories = data
            }
            .store(in: &cancellable)
    }
}
