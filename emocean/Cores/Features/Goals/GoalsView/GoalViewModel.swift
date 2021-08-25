//
//  GoalViewModel.swift
//  emocean
//
//  Created by Christian Adiputra on 03/08/21.
//

import Foundation
import SwiftUI
import Combine

class GoalViewModel: ObservableObject {
    
    @Published var goals: [Goal] = []
    private var cancellable = Set<AnyCancellable>()
    private var goalRepo = GoalRepository()
    var getId: Int = 0
    var getGoal: Goal = Goal(id: 0, deviceId: "",content: "", completed: false, createdAt: "", category: Category(id: 1, name: "Work"))
    var currentGoal: CurrentGoal = CurrentGoal(id: 0,content: "", status: false, categoryName: "")
    init() {
        print("\(UIDevice.current.identifierForVendor?.uuidString)")
        fetchData()
    }
    
    func delete(indexSet: IndexSet) {
        goals.remove(atOffsets: indexSet)
    }
    
}

//MARK: - METHODS
extension GoalViewModel {
    func fetchData(){
        goalRepo.getAllData()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let err):
                    print(err.errorDescription ?? "" + " goal")
                    guard let self = self else {return}
                    self.goals = self.goalRepo.getAllDummy()
                case .finished:
                    print("Finish fetch")
                }
            } receiveValue: { [weak self] data in
                print(data)
                self?.goals = data
                print(self?.goals)
            }
            .store(in: &cancellable)
        
    }
    
    func deleteData(at index: IndexSet?){
        var deletedGoal: Int = 0
        if (index != nil) {
            getId = index?.first ?? 0
            deletedGoal = goals[getId].id
        } else {
            deletedGoal = getId
        }
        
        guard let url = URL(string: "https://emocean.me/api/goals/\(deletedGoal)") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
//        useCompletion(fromURL: request) { {r} in
//            if let data = returnedData {
//                
//            }
//        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Error: error calling DELETE")
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
                        print("Error: Cannot convert data to JSON")
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
                    //self.fetchData()
                    
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
        }.resume()
        
    }
    
    func useCompletion(fromURL url: URLRequest, completionHandler: @escaping (_ data: [Data]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    print("Error: error calling DELETE")
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
                        print("Error: Cannot convert data to JSON")
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
                    //self.fetchData()
                    
                    
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            completionHandler([data])
        }.resume()
    }
    
 
}
