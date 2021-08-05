//
//  GoalView.swift
//  emocean
//
//  Created by Christian Adiputra on 30/07/21.
//

import SwiftUI

struct GoalView: View {
    @StateObject private var vm = GoalViewModel()
    @State var selection: Bool = false
    @State var selectedGoal: Goal = GoalList.getGoal.first!
    @State var showModal: Bool = false
    @State var goals: [Goal] = [
        Goal(goal: "makan nasi seminggu sekali", category: "Work", date: "Sunday, 25 January", status: true),
        Goal(goal: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd", category: "Relationship", date: "Monday, 26 January", status: false),
        Goal(goal: "makan daging anjing dengan sayur kol", category: "Covid", date: "Tuesday, 27 January", status: true)
    ]
    //    @State var category: String = "Work"
    //    @State var goal: String =  "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd "
    //    @State var date: String = "25 January 2020"
    init() {
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
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
                    Text("On-Going").tag(false)
                    Text("Completed").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                List {
                    ForEach(goals, id: \.self) { item in
                        if selection == item.status {
                            GoalCell(category: item.category, goal: item.goal, date: item.date, isCompleted: item.status)
                                .onTapGesture {
                                    self.showModal.toggle()
                                    self.selectedGoal = item
                                }
                        }
                    }
                    .onDelete(perform: delete)
                    .listRowBackground(Color.clear)
                }
                
//                .sheet(isPresented: $showModal, content: {
//                    GoalDetailView(goal: self.selectedGoal, isShow: $showModal).padding()
//                })
            }
            GoalDetailView(goal: self.selectedGoal, isShow: $showModal).padding()
        }
    }
    func delete(indexSet: IndexSet) {
        goals.remove(atOffsets: indexSet)
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
    }
}
