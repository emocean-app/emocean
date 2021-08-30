//
//  WeeklyLastGoal.swift
//  emocean
//
//  Created by Wilson Adrilia on 16/08/2021.
//

import SwiftUI
import Lottie

struct WeeklyLastGoal: View {
    // MARK: ENVIRONMENT
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var env: WeeklyViewModel
    // MARK: PROPERTIES
    let time = Time()
    @State var selected: Int = 0
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    private var model: FifthWeeklyCheckinStep
    // MARK: INIT
    init(model: WeeklyCheckinStep) {
        guard let model = model as? FifthWeeklyCheckinStep else {
            self.model = FifthWeeklyCheckinStep(id: 0, next: 0, nextSecondary: 0)
            return
        }
        self.model = model
    }
    // MARK: BODY
    var body: some View {
        GeometryReader { reader in // START: GEOMETRY
            ScrollView { // START: SCROLLV
                VStack { // START: VSTACK
                    // - TABVIEW
                    TabView(selection: $selected) { // START: TABV
                        FirstPages(theme: time.getRawValue())
                            .tag(0)
                        TextViewPages(theme: time.getRawValue(), title: "You've set goal last week")
                            .tag(1)
                        TextViewPages(theme: time.getRawValue(), title: "Did you achieve your goal?")
                            .tag(2)
                    } // END: TABV
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.horizontal, 0)
                    .frame(height: reader.size.height * 0.9)
                    // Show the button if the Tabview index is 2
                    if selected == 2 {
                        HStack { // START: HSTACK
                            // - NO BUTTON
                            PrimaryButton(content: {
                                Text("No")
                            }, maxWidth: 100, action: {
                                env.goToNextStep(id: model.nextSecondary)
                            })
                            // - YES BUTTON
                            PrimaryButton(content: {
                                Text("Yes")
                            }, maxWidth: 100, action: {
                                env.goToNextStep(id: model.next)
                            })
                        } // END: HSTACK
                    }
                } // END: VSTACK
            } // END: SCROLLV
            .frame(minHeight: reader.size.height)
        } // END: GEOMETRY
    }
}

// MARK: - COMPONENTS

struct FirstPages: View {
    // MARK: PROPERTIES
    let theme: String
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) { // START: VSTACK
            Spacer()
            // - PROMPT
            Text("Okay! Your new goal is set! \n but before that...")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: 350, alignment: .center)
                .padding(.leading, 0)
                .multilineTextAlignment(.center)
            Spacer()
        } // END: VSTACK
        .foregroundColor(theme == "Night" ? .white : .primary)
    }
}

struct TextViewPages: View {
    // MARK: PROPERTIES
    let theme: String
    @State var title: String
    var date: String = "Monday, 5 July 2021"
    // MARK: BODY
    var body: some View {
        VStack { // START: VSTACK
            Spacer()
            Spacer()
            // - PROMPT
            Text(title).font(.title2)
                .fontWeight(.semibold)
            // - TEXTVIEW
            GoalTextView(description: "This is my goal last week")
                .padding(.horizontal,16)
            // - TEXT DATE
            Text(date)
            Spacer()
        } // END: VSTACK
    }
}

// MARK: - PREVIEW

struct WeeklyLastGoal_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeeklyViewModel()
        WeeklyLastGoal(model: viewModel.currentStep)
            .background(Color.theme.seaBottomGradient)
    }
}
