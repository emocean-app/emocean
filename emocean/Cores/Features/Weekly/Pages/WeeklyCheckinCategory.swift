//
//  WeeklyCheckinCategory.swift
//  emocean
//
//  Created by Puras Handharmahua on 21/08/21.
//

import SwiftUI

struct WeeklyCheckinCategory: View {
    // MARK: ENVIRONMENT
    @EnvironmentObject var env: WeeklyViewModel
    // MARK: POPERTIES
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var time = Time()
    // MARK: BODY
    var body: some View {
        GeometryReader { reader in // START: GEOMETRY
            ScrollView { // START: SCROLLV
                VStack { // START: VSTACK
                    Spacer()
                    Spacer()
                    // - Top Text
                    topPrompt
                    // - Bottom Text
                    bottomPrompt
                    Spacer(minLength: 10)
                    // - Category TabView
                    tabView
                    // - Button
                    PrimaryButton {
                        Text("Yes!")
                            .padding(.horizontal)
                    } action: {
                        env.goToNextStep(id: env.currentStep.next)
                    }
                    Spacer()
                        .frame(height: 25)
                }
                .frame(
                    minHeight: reader.size.height
                ) // END: VSTACK
                .preferredColorScheme(time.timeRange == .night ? .dark : .light)
            } // END: SCROLLV
        } // END: GEOMETRY
    }
}

// MARK: - COMPONENTS

extension WeeklyCheckinCategory {
    // View for TabView Item
    var tabViewItem: some View {
        VStack { // START: VSTACK
            LazyVGrid(columns: columns, spacing: 20, content: { // START: VGRID
                ForEach(0..<8) { _ in // START: FOREACH
                    // Button
                    ButtonOutlined(
                        text: "Dummy",
                        isSelected: false,
                        isLight: time.getRawValue() == "Night" ,
                        action: {
                            print("Tes")
                        }
                    )
                    .padding(.horizontal, 5)
                } // END: FOREACH
            }) // END: VGRID
            .padding(.top, 5)
            Spacer()
        } // END: VSTACK
    }
    // Top Prompt View
    var topPrompt: some View {
        HStack { // START: HSTACK
            Spacer()
            Text("What aspect of your life do you want to change?")
                .font(.title2)
                .fontWeight(.medium)
                .frame(
                    maxWidth: .infinity
                )
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            Spacer()
        } // END: HSTACK
    }
    // Bottom Prompt
    var bottomPrompt: some View {
        HStack { // START: HSTACK
            Spacer()
            Text("Focus on the most important thing to you")
                .frame(
                    maxWidth: .infinity
                )
                .padding(.top, 5)
                .multilineTextAlignment(.center)
            Spacer()
        } // END: HSTACK
    }
    // Category TabView
    var tabView: some View {
        TabView { // START: TABVIEW
            tabViewItem
            tabViewItem
            tabViewItem
        } // END: TABVIEW
        .tabViewStyle(PageTabViewStyle())
        .frame(maxHeight: 375)
        .padding()
        .padding(.horizontal)
    }
}

// MARK: - PREVIEW

struct WeeklyCheckinCategory_Previews: PreviewProvider {
    private var time = Time()
    static var previews: some View {
        let viewModel = WeeklyViewModel()
        WeeklyCheckinCategory()
            .environmentObject(viewModel)
    }
}
