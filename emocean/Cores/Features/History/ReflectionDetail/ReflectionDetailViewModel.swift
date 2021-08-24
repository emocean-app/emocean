//
//  ReflectionDetailViewModel.swift
//  emocean
//
//  Created by Puras Handharmahua on 01/08/21.
//

import Foundation

class ReflectionDetailViewModel: ObservableObject {
    // MARK: - METHODS
    func getFormattedDate(format: String, from date: DateComponents) -> String {
        let date = Calendar.current.date(from: date)

        guard let dateUnwrap = date else { return "" }

        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: dateUnwrap)
    }

    func getFormattedDate(format: String, from date: Date) -> String {
        let calendar = Calendar.current.dateComponents([.day, .month, .year], from: date)
        return getFormattedDate(format: format, from: calendar)
    }
}
