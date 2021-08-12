//
//  GoalView.swift
//  emocean
//
//  Created by Christian Adiputra on 30/07/21.
//

import SwiftUI

struct GoalView: View {
    @StateObject private var vm = GoalViewModel()
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @State var selection: Bool = false
    @State var selectedGoal: Goal = GoalList.getGoal.first!
    @State var goals: [Goal] = [
        Goal(goal: "makan nasi seminggu sekali", category: "Work", date: "Sunday, 25 January", status: true),
        Goal(goal: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd Hello Mr Crab adaasda daskdadmak adksadka adsnkd", category: "Relationship", date: "Monday, 26 January", status: false),
        Goal(goal: "makan daging anjing dengan sayur kol", category: "Covid", date: "Tuesday, 27 January", status: true)
    ]
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
                                    self.selectedGoal = item
                                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                                        GoalDetailView(goal: selectedGoal).padding()
                                    }
                                    
                                }
                        }
                    }
                    .onDelete(perform: delete)
                    .listRowBackground(Color.clear)
                }
            }
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


struct ViewControllerHolder {
    weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
    static var defaultValue: ViewControllerHolder {
        return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController)
    }
}

extension EnvironmentValues {
    var viewController: UIViewController? {
        get { return self[ViewControllerKey.self].value }
        set { self[ViewControllerKey.self].value = newValue }
    }
}

extension UIViewController {
    func present<Content: View>(style: UIModalPresentationStyle = .automatic, transitionStyle: UIModalTransitionStyle = .coverVertical, @ViewBuilder builder: () -> Content) {
        let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
        toPresent.modalPresentationStyle = style
        toPresent.modalTransitionStyle = transitionStyle
        toPresent.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        toPresent.rootView = AnyView(
            builder()
                .environment(\.viewController, toPresent)
        )
        self.present(toPresent, animated: true, completion: nil)
    }
}
