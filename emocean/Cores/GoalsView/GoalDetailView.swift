//
//  GoalDetailView.swift
//  emocean
//
//  Created by Christian Adiputra on 28/07/21.
//

import SwiftUI

struct GoalDetailView: View {
    // MARK: - PROPERTIES
    @State var goal: String
    @State var date: String
    @Binding var isShow: Bool
    private let mainColor = Color(red: 16/255, green: 28/255, blue: 56/255)
    private let clearColor = Color.clear
    var body: some View {
        VStack { // START: VSTACK
            HStack { // START: HSTACK
                Text(date)
                    .font(.footnote)
                Spacer()
                Text("X")
                    .bold()
                    .foregroundColor(.gray)
                    .onTapGesture {
                        isShow = false
                    }
            } // END: HSTACK
            .padding()
            Spacer()
            Text(goal)
                .padding()
                .font(.body)
                .frame(width: .infinity)
            Spacer()
            HStack { // START: HSTACK
                PrimaryButton(content: {
                    HStack{
                        Text("Complete")
                            .font(.subheadline)
                        Image(systemName: "pencil")
                            .foregroundColor(.white)
                    }
                }, maxWidth: 100, action: {})
                EditButton(action: {})
                Image(systemName: "trash.circle")
                    .resizable()
                    .foregroundColor(mainColor)
                    .frame(width: 50, height: 50)
                    .onTapGesture {
                        // DEL FUNCTION
                    }
            } // END: HSTACK
            .padding(.horizontal)
            .padding(.bottom)
        } // END: VSTACK
        .frame(height: 253)
        .background(Color.white)
        .cornerRadius(25)
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal:"I Want to Focus on myself more so one day I’ll achieve the things I want to be able to eat all you can eat martabak",date:"January 30th 2021",isShow:.constant(false))
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
        Button(action: {}) {
            HStack {
                Text("Edit")
                    .font(.subheadline)
                Image(systemName: "pencil")
                    .foregroundColor(mainColor)
            }.frame(maxWidth: 60)
        }
        .foregroundColor(mainColor)
        .padding()
        .padding(.horizontal,20)
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
