//
//  GoalView.swift
//  emocean
//
//  Created by Christian Adiputra on 30/07/21.
//

import SwiftUI

struct GoalView: View {
    @StateObject private var goalViewModel = GoalViewModel()
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    @State var selection: Bool = false
    @State var isModalShown = false
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
                        .onTapGesture {
                            isModalShown = true
                        }
                }
                .padding(.horizontal,20)
                Picker("Status", selection: $selection) {
                    Text("On-Going").tag(false)
                    Text("Completed").tag(true)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                List {
                    ForEach(goalViewModel.goals) { item in
                        if selection == item.completed {
                            GoalCell(category: item.category?.name ?? "", goal: item.content, date: item.createdAt, isCompleted: item.completed)
                                .onTapGesture {
                                    goalViewModel.getGoal =  item
                                    self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
                                        GoalDetailView(goal: item).padding()
                                    }
                                    
                                }
                        }
                    }
                    .onDelete(perform: goalViewModel.delete)
                    .listRowBackground(Color.clear)
                }
            }
        }
        .sheet(isPresented: $isModalShown, content: {
            GoalFormView(showModal: $isModalShown)
        })
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
