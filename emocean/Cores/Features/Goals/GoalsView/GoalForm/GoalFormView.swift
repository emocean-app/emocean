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
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Category", selection: $category) {
                    ForEach(viewModel.categories) { category in
                        Text(category.name).tag(category.name)
                    }
                }

                TextField("Goal", text: $goal)
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle(Text("New Goal"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button(action: {
                    showModal = false
                }, label: {
                    Text("Cancel")
                        .font(.body)
                }), trailing: Button(action: {
                    viewModel.goalpost.content = goal
                    viewModel.goalpost.categoryId = category
                    viewModel.addGoal()
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
        GoalFormView(showModal: .constant(true))
    }
}
