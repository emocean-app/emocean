//
//  GoalView.swift
//  emocean
//
//  Created by Christian Adiputra on 30/07/21.
//

import SwiftUI

struct GoalView: View {
    @State var selection: String = "Newest"
    @State var category: String = "Work"
    @State var goal: String =  "Hello Mr Crab adaasda daskdadmak adksadka adsnkd"
    @State var date: String = "25 January 2020"
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
            VStack {
                HStack {
                    Picker(
                        selection: $selection,
                        label:
                            HStack {
                                Text("Goals")
                                    .font(.largeTitle)
                                Image(systemName: "chevron.down")
                                    .frame(maxWidth: 30, maxHeight: 30, alignment: .center)
                            }
                            .foregroundColor(Color.theme.grayPrimary),
                        content: {
                            Text("Newest").tag("Newest")
                                .onTapGesture {
                                    selection = "Newest"
                                }
                            Text("Oldest").tag("Oldest")
                                .onTapGesture {
                                    selection = "Oldest"
                                }
                            Text("Completed").tag("Completed")
                                .onTapGesture {
                                    selection = "Completed"
                                }
                        }
                    ).pickerStyle(MenuPickerStyle())
                    Spacer()
                    Image(systemName: "plus")
                        .frame(maxWidth: 30, maxHeight: 30, alignment: .center)
                        .foregroundColor(Color.theme.grayPrimary)
                }
                .padding()
                ScrollView {
                    VStack {
                        GoalCell(category: $category, goal: $goal, date: $date)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        GoalCell(category: $category, goal: $goal, date: $date)
                            .padding(.horizontal,20)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
