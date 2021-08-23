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
        .environmentObject(viewModel)
    }
}

// MARK: - COMPONENTS
extension WeeklyView {
    // BACKGROUND SELECTION
    var background: some View {
        Group { // START: GROUP
            switch viewModel.getBackground() {
            case .bubble:
                WeeklyBubbleBackground(isBubble: viewModel.selectedTabIndex != 2)
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            case .sky:
                WeeklySkyBackground()
                    .transition(.move(edge: .top))
                    .animation(.easeInOut)
            case .scenery:
                WeeklySceneryBackground()
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            }
        } // END: GROUP
    }
    // CONTENT SELECTION
    var content: some View {
        Group {
            switch viewModel.getScreenState() {
            case .primary:
                WeeklyCheckin(
                    selected: $viewModel.selectedTabIndex,
                    model: viewModel.currentStep
                )
            case .secondary:
                WeeklyForm(
                    model: viewModel.currentStep
                )
            case .third:
                WeeklyConfirmation(model: viewModel.currentStep)
            case .fourth:
                WeeklyCheckinCategory()
            case .fifth:
                WeeklyLastGoal(model: viewModel.currentStep)
            case .sixth:
                WeeklyPrompt()
            }
        }
    }
}

// MARK: - PREVIEW
struct WeeklyView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyView()
    }
}
