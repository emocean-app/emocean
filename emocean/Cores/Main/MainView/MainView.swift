//
//  MainView.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var settingsEnv: SettingsViewModel
    @StateObject var viewModel = MainViewModel()
    @State var shouldShowCheckin = false
    @State var shouldShowReflection = false
    @State var showSettings = false
    @State var showOnboarding = UserDefaults.standard.object(forKey: "onboardingLaunched") == nil
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
                    .onTapGesture {
                        shouldShowReflection = true
                    }
                    .padding(.vertical, 30)

                if !viewModel.goals.isEmpty {
                    Text("Recent Goals")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text(viewModel.goals[viewModel.goals.count - 1].content)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.white)
                        .padding(.top, 1)
                }

                if let progress = viewModel.progress {
                    EmotionChart(
                        red: viewModel.progressCount["red"] ?? 0,
                        blue: viewModel.progressCount["blue"] ?? 0,
                        green: viewModel.progressCount["green"] ?? 0,
                        yellow: viewModel.progressCount["yellow"] ?? 0,
                        image: progress.mood.imageUrl
                    )
                        .padding(.vertical)
                }

                if let progress = viewModel.progress,
                   !progress.progress.isEmpty {
                    Text("Emotional Pattern")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    ChartDescriptionView(quadrants: progress.progress)
                }

                Spacer()
                    .frame(height: 50)

            }
            .padding(.horizontal, 30)
            .padding(.vertical)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]
                    ),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        })
        .preferredColorScheme(time.getMode())
        .background(Color.theme.seaBottomGradient)
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $shouldShowCheckin, content: {
            CheckinView()
        })
        .fullScreenCover(isPresented: $showSettings, content: {
            SettingsView()
        })
        .fullScreenCover(isPresented: $shouldShowReflection, content: {
            WeeklyView()
        })
        .fullScreenCover(isPresented: $showOnboarding, content: {
                    OnboardingView()
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
