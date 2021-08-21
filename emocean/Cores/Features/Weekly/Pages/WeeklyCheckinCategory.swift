//
//  WeeklyCheckinCategory.swift
//  emocean
//
//  Created by Puras Handharmahua on 21/08/21.
//

import SwiftUI

struct WeeklyCheckinCategory: View {
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
                    // Text
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
                    HStack { // START: HSTACK
                        Spacer()
                        Text("Focus on the most important thing to you")
                            .frame(
                                maxWidth: .infinity
                            )
                            .multilineTextAlignment(.center)
                        Spacer()
                    } // END: HSTACK
                    Spacer()
                    // Category TabView
                    TabView { // START: TABVIEW
                        tabViewItem
                        tabViewItem
                        tabViewItem
                    } // END: TABVIEW
                    .tabViewStyle(PageTabViewStyle())
                    .frame(maxHeight: 375)
                    .padding()
                    .padding(.horizontal)
                    // Button
                    PrimaryButton {
                        Text("Yes!")
                            .padding(.horizontal)
                    } action: {
                        print("NEXT")
                    }
                    Spacer()
                        .frame(height: 25)
                }
                .frame(
                    minHeight: reader.size.height
                ) // END: VSTACK
                .preferredColorScheme(time.timeRange == .night ? .dark : .light)
            } // END: SCROLLV
            .background(
                LottieView(
                    filename: "\(time.getRawValue())Ending",
                    contentMode: .scaleAspectFit
                )
                    .ignoresSafeArea()
            )
        } // END: GEOMETRY
    }
}

// MARK: - COMPONENTS

extension WeeklyCheckinCategory {
    var tabViewItem: some View {
        VStack { // START: VSTACK
            LazyVGrid(columns: columns, spacing: 20, content: { // START: VGRID
                ForEach(0..<8) { _ in // START: FOREACH
                    // Button
                    ButtonOutlined(
                        text: "Dummy",
                        isSelected: false,
                        isLight: false,
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
}

// MARK: - PREVIEW

struct WeeklyCheckinCategory_Previews: PreviewProvider {
    private var time = Time()
    static var previews: some View {
        WeeklyCheckinCategory()
    }
}
