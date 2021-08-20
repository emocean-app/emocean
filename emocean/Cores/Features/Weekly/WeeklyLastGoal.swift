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

struct WeeklyLastGoal_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyLastGoal()
    }
}

struct FirstPages: View {
    let theme: String
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Spacer().frame(height: 150)
            Group {
            Text("Okay! Your new goal is set! \n but before that...")
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

struct SecondPages: View {
    let theme: String
    var date: String = "Monday, 5 July 2021"
    var body: some View {
        VStack {
            Spacer()
            Spacer().frame(height: 200)
            Text("You've set goal last week").font(.title2)
                .fontWeight(.semibold)
            GoalTextView()
                .padding(.horizontal,16)
            Text(date)
            Spacer()
            Spacer()
        }
    }
}

struct ThirdPages: View {
    let theme: String
    var date: String = "Monday, 5 July 2021"
    var body: some View {

        VStack {
            Spacer()
            Spacer().frame(height: 200)
            Text("Did you achieve your goal?").font(.title2)
                .fontWeight(.semibold)
            GoalTextView()
                .padding(.horizontal,16)
            Text(date)
            Spacer()
            Spacer()
        }
        
    }
}

extension WeeklyLastGoal {
    var contentContainer: some View {
        VStack {
            pages
        }
    }
    
    var pages: some View {
        VStack{
        TabView(selection: $selected) {
            FirstPages(theme: time.getRawValue()).tag(0)
            SecondPages(theme: time.getRawValue()).tag(1)
            ThirdPages(theme: time.getRawValue()).tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .padding(.horizontal, 0)
        .frame(height: 725)
            if selected == 2 {
                VStack {
                    Spacer()
                    Spacer().frame(height: 15)
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
                    Spacer()
                }
            }
        }
        
        
    }
}