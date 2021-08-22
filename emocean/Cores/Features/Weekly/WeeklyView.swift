//
//  WeeklyView.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import SwiftUI

struct WeeklyView: View {
    // MARK: PROPERTIES
    @StateObject private var viewModel = WeeklyViewModel()
    var body: some View {
        ZStack { // START: ZTACK
            // - BACKGROUND
            background
                .ignoresSafeArea()
            content
        } // END: ZTACK
    }
    // BACKGROUND SELECTION
    var background: some View {
        Group { // START: GROUP
            switch viewModel.getBackground() {
            case .bubble:
                WeeklyBubbleBackground(isBubble: viewModel.selectedTabIndex != 2)
            case .sky:
                WeeklySkyBackground()
            case .scenery:
                WeeklySceneryBackground()
            }
        } // END: GROUP
    }
    // CONTENT SELECTION
    var content: some View {
        Group {
            switch viewModel.getScreenState() {
            case .primary:
                WeeklyCheckin(select: $viewModel.selectedTabIndex)
            case .secondary:
                WeeklyForm()
            case .third:
                WeeklyConfirmation()
            case .fourth:
                WeeklyCheckinCategory()
            case .fifth:
                WeeklyLastGoal()
            case .sixth:
                WeeklyPrompt()
            }
        }
    }
}

struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
