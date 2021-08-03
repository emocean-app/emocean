//
//  MainView.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct MainView: View {
    @State var shouldShowCheckin = false
    
    var backgroundImage: String = ""
    let dayOfWeek: Int
    var headerForegroundColor: Color = .black

    init() {
        let calendar = Calendar(identifier: .gregorian)
        let recentDate = Date()
        let hour = calendar.component(.hour, from: recentDate)
        self.dayOfWeek = calendar.component(.weekday, from: recentDate)

        self.getImage(time: hour)
    }

    mutating func getImage(time hour: Int) {
        if hour < 11 {
            self.backgroundImage = "Morning"
        } else if hour < 15 {
            self.backgroundImage = "Noon"
        } else if hour < 17 {
            self.backgroundImage = "Sunset"
        } else {
            self.backgroundImage = "Night"
            self.headerForegroundColor = .white
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            MainHeaderView(shouldPopUpFullScreen: $shouldShowCheckin, backgroundImage: backgroundImage, headerForegroundColor: headerForegroundColor)

            Spacer()

            VStack {
                Text("Your Progress")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(alignment: .bottom) {
                    ForEach(0..<7) { idx in
                        ProgressBubble(dayOfWeek: idx, isDone: false, isToday: idx == dayOfWeek)
                            .padding(2)
                    }
                }

                ReflectButton()
                    .padding(.vertical)

                Text("Recent Goals")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("I want to focusing on myself rather than focusing on other people on social media. Therefore I can achieve more things that matter to me. I want to start focusing on myself")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.top, 3)
                    .padding(.bottom)

                EmotionChart(red: 10, blue: 20, green: 15, yellow: 30)

                Text("Emotional Pattern")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)

                ChartDescriptionView()

                Spacer()
                    .frame(height: 50)

            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom))
        })
        .background(Color.theme.seaBottomGradient)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $shouldShowCheckin, content: {
            VStack {
                Text("Hello World")
                Button(action: {
                    self.shouldShowCheckin = false
                }, label: {
                    Text("Close")
                })
            }
        })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .edgesIgnoringSafeArea(.all)
            .background(Color.theme.primary)
    }
}
