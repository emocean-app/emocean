//
//  TabBarView.swift
//  emocean
//
//  Created by Christian Adiputra on 29/07/21.
//
/// TAB BAR VIEW
/// to preview tab bar
///
/// - Parameter selectedTab: indicator for selected tab
///
import SwiftUI

struct TabBarView: View {
    @StateObject var settingsEnv = SettingsViewModel()
    @State private var selectedTab: Tab = .checkin
    var body: some View {
        VStack {
            switch selectedTab {
            case .checkin:
                MainView()
            case .goal:
                GoalView()
            case .history:
                WentFishingView()
            }
            TabBar(selectedTab: $selectedTab)
                .frame(maxHeight: 30)
        }
        .onAppear(){
            if settingsEnv.music {
                SoundManager.shared.playSound(sound: .ocean)
            }
        }
        .environmentObject(settingsEnv)
    }
}

enum Tab: String {
    case checkin
    case goal
    case history
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(SettingsViewModel())
    }
}

struct TempView: View {
    @Binding var title: String
    var body: some View {
        Color(.systemPink)
            .ignoresSafeArea()
            .navigationTitle(title)
    }
}
