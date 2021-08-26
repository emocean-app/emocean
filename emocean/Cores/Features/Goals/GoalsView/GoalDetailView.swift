//
//  GoalDetailView.swift
//  emocean
//
//  Created by Christian Adiputra on 28/07/21.
//
/// Detail View for Goal.
///
/// You have to define give padding.
///
/// ```
/// GoalCell(
///     goal: "I Want to Focus on myself more so one day I’llachive the things I want...",
///     date: "January 30th 2021",
///     edit: false
/// )
/// ```
///
/// - Parameter goal: The goal string
/// - Parameter date: The date string
/// - Parameter isShow: is the modal show bool
///

import SwiftUI

struct GoalDetailView: View {
    // MARK: - PROPERTIES
    var goal: Goal
    @State var value = 0.0
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    private let clearColor = Color.clear
    @StateObject private var goalViewModel = GoalViewModel()
    @ObservedObject private var viewModel = GoalFormViewModel()
    @State var isModalShown = false
    var body: some View {
        VStack (alignment: .leading){ // START: VSTACK
                HStack { // START: HSTACK
                    Text(Time.formatter(dateFormat: "EEEE, MMM d yyyy", from: Time.parseFromIso8601(from: goal.createdAt)))
                        .font(.footnote)
                    Spacer()
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width:20, height: 20)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            //isShow = false
                            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                        }
                } // END: HSTACK
                .padding(.horizontal,25)
                .padding(.top,25)
            ScrollView(){
                    Text(goal.content)
                        .padding(.leading,20)
                        .padding(.vertical)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.vertical,10)
                Spacer()
                HStack { // START: HSTACK
                    if !goal.completed {
                        
                        CompleteButton(action: {
                            viewModel.putMethod(currentGoal: CurrentGoal(id: goal.id, content: goal.content, status: true, categoryName: goal.category.name))
                            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                        })
                        .onDisappear {
                            goalViewModel.fetchData()
                        }
                        
                        EditButton(action: {
                            //goalViewModel.getGoal.content = goal.content
                            goalViewModel.currentGoal.content = goal.content
                            goalViewModel.currentGoal.id = goal.id
                            print(goalViewModel.currentGoal)
                            isModalShown = true
                        })
                        .onDisappear {
                            goalViewModel.fetchData()
                        }
                    }
                    
                    Spacer()
                    Image("Trash")
                        .resizable()
                        .foregroundColor(Color.theme.primary)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            // DEL FUNCTION
                            goalViewModel.getId = goal.id
                            goalViewModel.deleteData(at: nil)
                            self.viewControllerHolder?.dismiss(animated: true, completion: nil)
                            //goalViewModel.fetchData()
                        }
                        .onDisappear {
                            goalViewModel.fetchData()
                        }
                } // END: HSTACK
                .padding(.horizontal,25)
                .padding(.bottom)
        } // END: VSTACK
        .frame(minHeight: 200, maxHeight: 400)
        .background(Color.white)
        .cornerRadius(25)
        .sheet(isPresented: $isModalShown, content: {
            GoalFormView(showModal: $isModalShown, title: "Edit Goal", currentGoal: CurrentGoal(id: goal.id, content: goal.content, status: goal.completed, categoryName: goal.category.name))
        })
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal: Goal(id: 0, deviceId: "",content: "Work", completed: false , createdAt: "25 January 2021", category: Category(id: 1, name: "Work")))
            .previewLayout(.sizeThatFits)
            .padding(.horizontal,10)
            .background(Color.black)
    }
}

// MARK: - EditButton
struct EditButton: View {
    var action: () -> Void
    private let mainColor = Color(red: 16/255, green: 28/255, blue: 56/255)
    private let clearColor = Color.clear
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Edit")
                    .font(.subheadline)
                Image(systemName: "pencil")
                    .foregroundColor(mainColor)
            }.frame(width: 60)
        }
        .foregroundColor(mainColor)
        .padding()
        .padding(.horizontal,10)
        .background(
            ZStack {
                clearColor
                    .clipShape(Capsule())
                Capsule()
                    .stroke(
                        mainColor,
                        style: StrokeStyle(
                            lineWidth: 2
                        )
                    )
            }
        )
    }
}

struct CompleteButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Complete")
                    .font(.subheadline)
                Image(systemName: "checkmark")
                    .foregroundColor(Color.theme.grayPrimary)
            }.frame(width: 100)
        }
        .foregroundColor(Color.theme.grayPrimary)
        .padding()
        .padding(.horizontal,10)
        .background(
            ZStack {
                Color.theme.primary
                    .clipShape(Capsule())
                Capsule()
                    .stroke(
                        Color.theme.primary,
                        style: StrokeStyle(
                            lineWidth: 2
                        )
                    )
            }
        )
    }
}
