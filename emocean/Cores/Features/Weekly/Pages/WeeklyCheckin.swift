//
//  WeeklyCheckin.swift
//  emocean
//
//  Created by Wilson Adrilia on 18/08/2021.
//

import SwiftUI

struct WeeklyCheckin: View {
    // MARK: ENVIRONMENT
    @EnvironmentObject var env: WeeklyViewModel
    // MARK: PROPERTIES
    @Binding var select: Int
    private var model: PrimaryWeeklyCheckinStep
    // MARK: INIT
    init(selected: Binding<Int>, model: WeeklyCheckinStep) {
        self._select = selected
        guard let model = model as? PrimaryWeeklyCheckinStep else {
            self.model = PrimaryWeeklyCheckinStep(id: 0, next: 0)
            return
        }
        self.model = model
    }
    // MARK: BODY
    var body: some View {
        GeometryReader { reader in // START: READER
            ScrollView { // START: SCROLLVIEW
                VStack { // START: VSTACK
                    // - PAGES TAB VIEW
                    TabView(selection: $select) { // START: TABVIEW
                        TabViewsItem(firstText: "Hey, it's time for your",
                                     secondText: "Weekly Reflections!").tag(0)
                        TabViewsItem(firstText: "I noticed a pattern based on",
                                     secondText: "What you've\nshared with me").tag(1)
                        TabViewsItem(firstText: "It looks like you often felt",
                                     secondText: "Unseasy in Morning\nbecause of Social Media").tag(2)
                    } // END: TABVIEW
                    .tabViewStyle(PageTabViewStyle())
                    .frame(minHeight: reader.size.height * 0.9)
                    .padding(.horizontal, 0)
                    // Selection to show the primary button
                    if select == 2 {
                        // - YES! BUTTON
                        PrimaryButton(content: {
                            Text("Next")
                                .fontWeight(.bold)
                        }, maxWidth: 150, action: {
                            print("primary clicked")
                            env.goToNextStep(id: model.next)
                        })
                        .transition(.move(edge: .bottom))
                        .animation(.easeIn(duration: 0.25))
                    }
                } // END: VSTACK
            } // END: SCROLLVIEW
            .frame(minHeight: reader.size.height)
        } // END: READER
    }
}

// MARK: - COMPONENTS

// Tab View Items
struct TabViewsItem: View {
    // MARK: PROPERTIES
    @State var firstText: String
    @State var secondText: String
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) { // START: VSTACK
            Spacer()
            Group { // START: GROUP
                // - TOP TEXT
                Text(firstText)
                    .font(.title3)
                    .fontWeight(.regular)
                    .frame(alignment: .center)
                    .padding(.leading)
                    .foregroundColor(.white)
                // - BOTTOM TEXT
                Text(secondText)
                    .font(.title)
                    .fontWeight(.semibold)
                    .frame(alignment: .center)
                    .padding(.leading)
                    .foregroundColor(.white)
            } // END: GROUP
            Spacer()
        } // END: VSTACK
    }
}

// MARK: - PREVIEW

struct WeeklyCheckin_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeeklyViewModel()
        WeeklyCheckin(selected: .constant(0), model: viewModel.currentStep)
            .background(EMTheme.shared.sea.ignoresSafeArea())
            .environmentObject(viewModel)
    }
}
