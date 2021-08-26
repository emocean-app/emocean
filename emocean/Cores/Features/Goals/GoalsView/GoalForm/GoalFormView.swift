//
//  GoalFormView.swift
//  emocean
//
//  Created by Farrel Anshary on 12/08/21.
//

import SwiftUI

struct GoalFormView: View {
    @Binding var showModal: Bool
    @State var category = 0
    @State var goal = ""
    @State var searchText = ""
    @ObservedObject var viewModel = GoalFormViewModel()
    @ObservedObject var mainviewModel = GoalViewModel()
    @State var title: String
    @State var currentGoal: CurrentGoal?
    var body: some View {
        NavigationView {
            Form {
                if title == "New Goal"{
                    Picker("Category", selection: $category) {
                        ForEach(viewModel.categories) { category in
                            Text(category.name).tag(category.name)
                        }
                    }
                } else {
                    Text(currentGoal?.categoryName ?? "")
                }
                
                
                TextField(currentGoal?.content ?? "Goal", text: $goal)
                
                
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(Text(title))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    showModal = false
                }, label: {
                    Text("Cancel")
                        .font(.body)
                }), trailing: Button(action: {
                    if title == "New Goal" {
                        viewModel.goalpost.content = goal
                        viewModel.goalpost.categoryId = category
                        viewModel.addGoal()
                        mainviewModel.fetchData()
                    } else {
                        print(currentGoal)
                        viewModel.putMethod(currentGoal: CurrentGoal(id: currentGoal?.id ?? 0, content: goal, status: currentGoal?.status, categoryName: currentGoal?.categoryName ?? ""))
                        mainviewModel.fetchData()
                    }
                    
                    mainviewModel.fetchData()
                    showModal = false
                }, label: {
                    Text("Save")
                })
            )
        }
    }
}

struct GoalFormView_Previews: PreviewProvider {
    static var previews: some View {
        GoalFormView(showModal: .constant(true), title: "New Goal", currentGoal: (CurrentGoal(id: 1, content: "", status: false, categoryName: "Work")))
    }
}
