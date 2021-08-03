//
//  EMCalendarViewModel.swift
//  emocean
//
//  Created by Puras Handharmahua on 01/08/21.
//

import Foundation

class EMCalendarViewModel: ObservableObject {
    // MARK: PROPERTIES
    
    // Date State
    @Published var dateSelected: DateComponents = {
        let dateComp = Calendar.current.dateComponents([.day,.month,.year], from: Date())
        return dateComp
    }()
    
    // Current Displayed Month
    @Published var currentMonth: DateComponents = {
        let dateComp = Calendar.current.dateComponents([.month,.year], from: Date())
        return dateComp
    }()
    
    // Day of current selected date
    var day: Int {
        return dateSelected.day ?? 0
    }
    
    // Month's number of current displayed month
    var month: Int {
        return currentMonth.month ?? 0
    }
    
    // Year's number of current displayed month
    var year: Int {
        return currentMonth.year ?? 0
    }
    
    private let calendar = Calendar.current
    let days = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    
}

// MARK: - METHODS

extension EMCalendarViewModel {
    
    /// Get the number of days in month
    /// - Returns: Int of number of days in month
    func getNumberOfDaysInMonth() -> Int {
        let newDateComponents = DateComponents(
            year: year,
            month: month
        )
        let date = calendar.date(from: newDateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    /// Get the weekday number of the first day of the month
    /// - Returns: Int of weekday number
    func getFirstDayWeekday() -> Int {
        let newDateComponents = DateComponents(
            year: year,
            month: month
        )
        
        let firstDate = calendar.date(from: newDateComponents)!
        let weekDay = calendar.dateComponents([.weekday], from: firstDate)
        return weekDay.weekday ?? 0
    }
    
    
    /// Increment the current showed month
    func incrementMonth() {
        if month < 12 {
            currentMonth = DateComponents(
                year: year,
                month: month + 1
            )
        } else {
            currentMonth = DateComponents(
                year: year + 1,
                month: 1
            )
        }
    }
    
    /// Decrement the current showed month
    func decrementMonth() {
        if month > 1 {
            currentMonth = DateComponents(
                year: year,
                month: month - 1
            )
        } else {
            currentMonth = DateComponents(
                year: year - 1,
                month: 12
            )
        }
    }
    
    
    /// Get the name of the current showed month
    /// - Returns: String of current showed month's name
    func getMonthName() -> String {
        let newDateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: newDateComponents)!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        return formatter.string(from: date)
    }
    
    
    /// Get the number of the current showed Month's weeks
    /// - Returns: Int of current showed Month's weeks
    func getWeeksNumber() -> Int {
        let newDateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: newDateComponents)!
        
        var components = DateComponents()
        components.month = 1
        components.second = -1
        
        let lastDay = calendar.date(byAdding: components, to: date)!
        
        let dateComponents = calendar.dateComponents([.weekOfMonth], from: lastDay)
        
        return (dateComponents.weekOfMonth ?? 0) * 7
    }
    
    
    /// Check if the cell is today's date
    /// - Parameter cellNumber: Int of cell's number
    /// - Returns: Bool wether the cell is for today's date
    func isTodayDate(cellNumber: Int) -> Bool {
        let difference = cellNumber - getFirstDayWeekday() + 1
        
        let currentComponents = calendar.dateComponents([.day,.month,.year], from: Date())
        let cellComponents = DateComponents(year: year, month: month, day: difference)
        
        return currentComponents == cellComponents
    }
    
    
    /// Check if the cell is selected date
    /// - Parameter cellNumber: Int of cell's number
    /// - Returns: Bool wether the cell is selected date
    func isSelectedDate(cellNumber: Int) -> Bool {
        let difference = cellNumber - getFirstDayWeekday() + 1
        let cellComponents = DateComponents(year: year, month: month, day: difference)
        
        return dateSelected == cellComponents
    }
    
    
    /// Set the current selected date
    /// - Parameter cellNumber: Int of cell's number
    func setSelectedDate(cellNumber: Int) {
        let date = cellNumber - getFirstDayWeekday() + 1
        
        dateSelected = DateComponents(
            year: year,
            month: month,
            day: date
        )
    }
    
    /// Check if the cell is hold a valid date's number
    /// - Parameter cellNumber: Int of cell's number
    /// - Returns: Bool whether the current cell is hold a valid date's number
    func isCellAvailable(cellNumber: Int) -> Bool {
        let date = cellNumber - getFirstDayWeekday() + 1
        
        return date >= 1 && date <= getNumberOfDaysInMonth()
    }
    
    
    /// Get the string value of date's number
    /// - Parameter cellNumber: Int of cell's number
    /// - Returns: String of date or empty string
    func cellToDateString(cellNumber: Int) -> String {
        return isCellAvailable(cellNumber: cellNumber) ? "\(cellNumber - getFirstDayWeekday() + 1)" : ""
    }
}
