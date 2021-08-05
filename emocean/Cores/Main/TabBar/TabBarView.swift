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
    @State private var selectedTab: Tab = .checkin
    var body: some View {
        VStack {
            switch selectedTab {
            case .checkin:
                MainView()
            case .goal:
                GoalView()
            case .history:
                NavigationView {
                    TempView(title: .constant("History"))
                }
            }
            TabBar(selectedTab: $selectedTab)
                .frame(height: 30)
        }
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
