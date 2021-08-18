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
    
    @EnvironmentObject var env: CheckinViewModel
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

struct PageOne: View {
    let theme: String
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Spacer().frame(height: 150)
            Group {
            Text("There are things that you \n can't change")
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

struct PageTwo: View {
    let theme: String
    var date: String = "Monday, 5 July 2021"
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Spacer().frame(height: 150)
            Group {
            Text("reflect on how can you make \n yourself feel better")
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

struct PageThree: View {
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

extension WeeklyPrompt {
    var contentContainer: some View {
        VStack {
            pages
        }
    }
    
    var pages: some View {
        VStack{
        TabView(selection: $selected) {
            PageOne(theme: time.getRawValue()).tag(0)
            PageTwo(theme: time.getRawValue()).tag(1)
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
                        print(env.checkin.feedbacks)
                        showAction.toggle()
                    })
                    Spacer()
                }
            }
        }
        
        
    }
}

enum ThemeBG4: String {
    case morning = "Morning"
    case noon = "Noon"
    case sunset = "Sunset"
    case night = "Night"
}
