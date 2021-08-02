//
//  GoalView.swift
//  emocean
//
//  Created by Christian Adiputra on 30/07/21.
//

import SwiftUI

struct GoalView: View {
    @State var selection: Int = 0
    @State var category: String = "Work"
    @State var goal: String =  "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd "
    @State var date: String = "25 January 2020"
    init() {
        
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.grayPrimary)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(Color.theme.primary)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor(Color.theme.grayPrimary)], for: .normal)
    }
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("Goals")
                        .font(.largeTitle)
                        .foregroundColor(Color.theme.grayPrimary)
                    Spacer()
                    Image(systemName: "plus")
                        .frame(maxWidth: 25, maxHeight: 25, alignment: .center)
                        .cornerRadius(30)
                        .overlay(RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.theme.grayPrimary, lineWidth: 2))
                        .foregroundColor(Color.theme.grayPrimary)
                }
                .padding(.horizontal,20)
                Picker("Status", selection: $selection) {
                    Text("On-Going").tag(0)
                    Text("Completed").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                ScrollView {
                    VStack {
                        GoalCell(category: $category, goal: $goal, date: $date)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 10)
                        GoalCell(category: $category, goal: $goal, date: $date)
                            .padding(.horizontal,20)
                            .padding(.bottom, 10)
                        GoalDetailView(goal: $goal, date: $date, isShow: .constant(false))
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
