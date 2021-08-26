//
//  WeeklyPrompt.swift
//  emocean
//
//  Created by Wilson Adrilia on 18/08/2021.
//

import SwiftUI
import Lottie

struct WeeklyPrompt: View {
    // MARK: ENVIRONMENT
    @Environment(\.presentationMode) var presentationMode
    // MARK: PROPERTIES
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    @State var selected: Int = 0
    let time = Time()
    // MARK: BODY
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ZStack { // START: VSTACK
                    TabView(selection: $selected) { // START: TABVIEW
                        // - TABVIEW
                        TabViewItem(
                            theme: time.getRawValue(),
                            prompt: "There are things that you\ncan't change"
                        )
                        .tag(0)
                        TabViewItem(
                            theme: time.getRawValue(),
                            prompt: "But focus on the things\nYou can change"
                        )
                        .tag(1)
                        TabViewItem(
                            theme: time.getRawValue(),
                            prompt: "Reflect on how can you make\nyourself feel better"
                        )
                        .tag(2)
                    } // END: VSTACK
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.horizontal, 0)
                    // Show button if the tabview index is 2
                    if selected == 2 {
                        VStack { // START: VSTACK
                            Spacer()
                            // - THANKS! BUTTON
                            PrimaryButton(content: {
                                Text("Thanks!")
                            }, maxWidth: 177, action: {
                                showAction.toggle()
                            })
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut)
                        } // END: VSTACK
                    }
                } // END: VSTACK
                .frame(minHeight: reader .size.height)
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

// MARK: - COMPONENTS

struct TabViewItem: View {
    // MARK: PROPERTIES
    let theme: String
    @State var prompt: String
    // MARK: BODY
    var body: some View {
        VStack(alignment: .leading) { // START: VSTACK
            Spacer()
            Text(prompt)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer()
        } // END: VSTACK
        .foregroundColor(theme == "Night" ? .white : .primary)
    }
}

// MARK: - PREVIEW

struct WeeklyPrompt_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyPrompt()
            .background(Color.theme.nightTopGradient)
    }
}
