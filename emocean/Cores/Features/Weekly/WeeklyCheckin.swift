//
//  WeeklyCheckin.swift
//  emocean
//
//  Created by Wilson Adrilia on 18/08/2021.
//

import SwiftUI

struct WeeklyCheckin: View {
    @State var select: Int = 0
    
    var body: some View {
        ZStack {
            if select == 0 || select == 1 {
                Bubble()
                // Button Close
                VStack { // START: VSTACK
                    HStack { // START: HSTACK
                        Spacer()
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.white)
                            .onTapGesture {

                            }
                            .zIndex(2)
                    } // END: HSTACK
                    .padding(.horizontal, 28)
                    .padding(.top, 20)
                    Spacer()
                } // END: VSTACK
            }
            ScrollView {
                VStack {
                    TabView(selection: $select) {
                        TabViews(firstText: "Hey, it's time for your",
                                 secondText: "Weekly Reflections!").tag(0)
                        TabViews(firstText: "I noticed a pattern based on",
                                 secondText: "What you've\nshared with me").tag(1)
                        TabViews(firstText: "It looks like you often felt",
                                 secondText: "Unseasy in Morning\nbecause of Social Media").tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding(.horizontal, 0)
                .frame(height: 725)
                    if select == 2 {
                        VStack {
                            Spacer()
                            Spacer().frame(height: 15)
                            PrimaryButton(content: {
                                Text("Next").fontWeight(.bold)
                            }, maxWidth: 150, action: {
                    
                            })
                            Spacer()
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}

struct TabViews: View {
    @State var firstText: String
    @State var secondText: String
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Spacer().frame(height: 100)
            Group {
            Text(firstText)
                .font(.title3)
                .fontWeight(.regular)
                .frame(alignment: .center)
                .padding(.leading)
                .foregroundColor(.white)
            Text(secondText)
                .font(.title)
                .fontWeight(.semibold)
                .frame(alignment: .center)
                .padding(.leading)
                .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

struct Bubble: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer().frame(height: 80)
                HStack {
                    Spacer()
                    Spacer()
                    .frame(width: geometry.size.width / 4)
                    Image("Bubble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 4)
                    .rotationEffect(.degrees(-180))
                    .opacity(0.4)
                    Spacer().frame(width: 10)
                }
                Spacer()
                Spacer()
                HStack {
                    Spacer().frame(width: 10)
                    Image("Bubble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 4)
                    .opacity(0.4)
                    Spacer()
                }
            }
        }
    }
}

struct WeeklyCheckin_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyCheckin().background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
