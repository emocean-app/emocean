//
//  WeeklyLastGoal.swift
//  emocean
//
//  Created by Wilson Adrilia on 16/08/2021.
//

import SwiftUI
import Lottie

struct WeeklyLastGoal: View {
    @Environment(\.presentationMode) var presentationMode
    let time = Time()
    @State var selected: Int = 0
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                VStack {
                    TabView(selection: $selected) {
                        FirstPages(theme: time.getRawValue())
                            .tag(0)
                        TextViewPages(theme: time.getRawValue(), title: "You've set goal last week")
                            .tag(1)
                        TextViewPages(theme: time.getRawValue(), title: "Did you achieve your goal?")
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.horizontal, 0)
                    .frame(height: reader.size.height * 0.9)
                    if selected == 2 {
                        HStack {
                            PrimaryButton(content: {
                                Text("No")
                            }, maxWidth: 100, action: {
                                showAction.toggle()
                            })
                            PrimaryButton(content: {
                                Text("Yes")
                            }, maxWidth: 100, action: {
                                showAction.toggle()
                            })
                        }
                    }
                }
            }
            .frame(minHeight: reader.size.height)
        }
    }
}

struct FirstPages: View {
    let theme: String
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Group {
                Text("Okay! Your new goal is set! \n but before that...")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 350, alignment: .center)
                    .padding(.leading, 0)
                    .multilineTextAlignment(.center)
            }
            Spacer()
        }
        .foregroundColor(theme == "Night" ? .white : .primary)
    }
}

struct TextViewPages: View {
    let theme: String
    @State var title: String
    var date: String = "Monday, 5 July 2021"
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text(title).font(.title2)
                .fontWeight(.semibold)
            GoalTextView()
                .padding(.horizontal,16)
            Text(date)
            Spacer()
        }
    }
}

struct WeeklyLastGoal_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyLastGoal()
            .background(Color.theme.seaBottomGradient)
    }
}
