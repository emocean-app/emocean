//
//  GoalFormViewModel.swift
//  emocean
//
//  Created by Farrel Anshary on 12/08/21.
//

import Foundation
import SwiftUI
import Combine

class GoalFormViewModel: ObservableObject {
    private var categoryRepo = CategoryRepository()
    @ObservedObject private var goalViewModel = GoalViewModel()
    private var goalRepo = GoalRepository()
    var getGoal: Goal = Goal(id: 0, deviceId: "",content: "", completed: false, createdAt: "", category: Category(id: 1, name: "Work"))
    var updateGoal: CurrentGoal = CurrentGoal(id: 0, content: "", status: false, categoryName: "")
    private var postResponse = ""
    var goalpost = Goalpost(
        deviceId: "\(UIDevice.current.identifierForVendor?.uuidString ?? "simulator")",
        content: "",
        categoryId: 5)
    private var cancellable = Set<AnyCancellable>()

    @Published var categories = [Category]()
    
    init() {
        getAllData()
    }

    private func getAllData() {
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
    
    func addGoal() {
        goalRepo
            .postData(body: goalpost)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "Error")
                case .finished:
                    print("Finsihed post Goal")
                    print(self.postResponse)
                }
            } receiveValue: { [weak self] data in
                self?.postResponse = data
            }
            .store(in: &cancellable)
    }

    func putMethod(currentGoal: CurrentGoal) {
        guard let url = URL(string: "https://emocean.me/api/goals/\(currentGoal.id)") else {
            print("Error: cannot create URL")
            return
        }
        
        // Create model
        struct UpdateData: Codable {
            let content: String?
            let completed: Bool?
        }
        let newData = UpdateData(content: currentGoal.content, completed: currentGoal.status)
        
        // Add data to the model
        let uploadDataModel = UpdateData(content: newData.content, completed: newData.completed)
        
        print(uploadDataModel)
        // Convert model to JSON data
        guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling PUT")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)

            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
    
}
