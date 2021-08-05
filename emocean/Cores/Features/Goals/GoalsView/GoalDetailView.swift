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
//    @Binding var goal: String
//    @Binding var date: String
    @Binding var isShow: Bool
    private let clearColor = Color.clear
    var body: some View {
        VStack (alignment: .leading){ // START: VSTACK
            if isShow {
                HStack { // START: HSTACK
                    Text(goal.date)
                        .font(.footnote)
                    Spacer()
                    Text("X")
                        .bold()
                        .foregroundColor(.gray)
                        .onTapGesture {
                            isShow = false
                        }
                } // END: HSTACK
                .padding(.horizontal)
                .padding(.top)
                //Spacer()
                Text(goal.goal)
                    .padding()
                    .font(.body)
                    .frame(width: .infinity)
                Spacer()
                HStack { // START: HSTACK
                    CompleteButton(action: {})
                    EditButton(action: {})
                    Image("Trash")
                        .resizable()
                        .foregroundColor(Color.theme.primary)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            // DEL FUNCTION
                        }
                } // END: HSTACK
                .padding(.horizontal)
                .padding(.bottom)
            }
        } // END: VSTACK
        .frame(height: 400)
        .background(Color.white)
        .cornerRadius(25)
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal: GoalList.getGoal.first!, isShow: .constant(true))
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