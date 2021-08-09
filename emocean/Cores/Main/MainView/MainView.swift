//
//  MainView.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var settingsEnv: SettingsViewModel
    @State var shouldShowCheckin = false
    @State var showSettings = false
    let dayOfWeek: Int
    let time = Time()

    init() {
        let calendar = Calendar(identifier: .gregorian)
        let recentDate = Date()
        self.dayOfWeek = calendar.component(.weekday, from: recentDate)
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            MainHeaderView(shouldPopUpFullScreen: $shouldShowCheckin, shouldShowSettingsModal: $showSettings)

            Spacer()

            VStack {
                Text("Your Progress")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(alignment: .bottom) {
                    ForEach(0..<7) { idx in
                        ProgressBubble(dayOfWeek: idx, isDone: false, isToday: idx == dayOfWeek - 1)
                    }
                }

                ReflectButton()
                    .padding(.vertical, 30)

                Text("Recent Goals")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text("I want to focusing on myself rather than focusing on other people on social media. Therefore I can achieve more things that matter to me. I want to start focusing on myself")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .padding(.top, 1)

                EmotionChart(red: 10, blue: 20, green: 15, yellow: 30)
                    .padding(.vertical)

                Text("Emotional Pattern")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)

                ChartDescriptionView()

                Spacer()
                    .frame(height: 50)

            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom))
        })
        .preferredColorScheme(time.getMode())
        .background(Color.theme.seaBottomGradient)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $shouldShowCheckin, content: {
            CheckinView()
        })
        .sheet(isPresented: $showSettings, content: {
            SettingsView(showModal: $showSettings)
        })
        .environmentObject(settingsEnv)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .edgesIgnoringSafeArea(.all)
            .background(Color.theme.primary)
            .environmentObject(SettingsViewModel())
    }
}
