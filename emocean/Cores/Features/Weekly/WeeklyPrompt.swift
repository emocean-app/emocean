//
//  WeeklyPrompt.swift
//  emocean
//
//  Created by Wilson Adrilia on 18/08/2021.
//

import SwiftUI
import Lottie

struct WeeklyPrompt: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    let time = Time()
    @State var selected: Int = 0
    var body: some View {
        ZStack {
            LottieView(filename: "\(time.getRawValue())Ending", contentMode: .scaleAspectFit).ignoresSafeArea(edges: .top)
            Image("R\(time.getRawValue())")
                .resizable()
                .scaledToFill()
            // content
            ScrollView {
                contentContainer
            }.edgesIgnoringSafeArea(.all)
        }.ignoresSafeArea()
    }
}

struct WeeklyPrompt_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyPrompt()
    }
}

// CONTENT VIEW
struct PromptViewPages: View {
    let theme: String
    @State var prompt: String
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Spacer().frame(height: 150)
            Group {
            Text(prompt)
                .font(.title2)
                .fontWeight(.semibold)
                .frame(width: 350, alignment: .center)
                .padding(.leading, 0)
                .multilineTextAlignment(.center)
            }
            Spacer()
        }.foregroundColor(theme == "Night" ? .white : .primary)
    }
}

extension WeeklyPrompt {
    var contentContainer: some View {
        VStack {
            content
        }
    }
    var content: some View {
        VStack {
        TabView(selection: $selected) {
            PromptViewPages(theme: time.getRawValue(), prompt: "There are things that you \n can't change").tag(0)
            PromptViewPages(theme: time.getRawValue(), prompt: "reflect on how can you make \n yourself feel better").tag(1)
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.horizontal, 0)
        .frame(height: 725)
            if selected == 1 {
                VStack {
                    Spacer()
                    Spacer().frame(height: 15)
                    PrimaryButton(content: {
                        Text("Thanks!")
                    }, maxWidth: 177, action: {
                        showAction.toggle()
                    })
                    Spacer()
                }
            }
        }
    }
}
