//
//  TabBar.swift
//  emocean
//
//  Created by Christian Adiputra on 29/07/21.
//
/// TAB BAR
///
///
/// - Parameter selectedTab: indicator for selected tab
///
import SwiftUI

struct TabBar: View {
    @Binding var selectedTab: Tab
    var body : some View {
        HStack { // START: HSTACK
            Button(action: { // START: BUTTON CHECKIN
                selectedTab = .checkin
            }, label: { // START: LABEL
                VStack(alignment: .center, spacing: 5) { // START: VSTACK
                    if(selectedTab == .checkin) {
                        Image("CheckInSelected")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    } else {
                        Image("CheckInDeselect")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    Text("Checkin")
                        .fontWeight(selectedTab == .checkin ? .bold : .regular)
                        .font(.footnote)
                        .foregroundColor(Color.theme.grayPrimary)
                } // END: VSTACK
            }) // END: LABEL & BUTTON CHECKIN
            .padding(.bottom)
            .padding(.leading)
            .buttonStyle(TabButtonStyle())
            Spacer()
            Button(action: { // START: BUTTON GOAL
                selectedTab = .goal
            }, label: { // START: LABEL
                VStack(alignment: .center, spacing: 5) { // START: VSTACK
                    if(selectedTab == .goal) {
                        Image("GoalsSelected")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    } else {
                        Image("GoalsDeselect")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    Text("Goal")
                        .fontWeight(selectedTab == .goal ? .bold : .regular)
                        .font(.footnote)
                        .foregroundColor(Color.theme.grayPrimary)
                } // END: VSTACK
            }) // END: LABEL & BUTTON GOAL
            .padding(.bottom)
            .buttonStyle(TabButtonStyle())
            Spacer()
            Button(action: { // START: BUTTON HISTORY
                selectedTab = .history
            }, label: { // START: LABEL
                VStack(alignment: .center, spacing: 5) { // START: VSTACK
                    if(selectedTab == .history) {
                        Image("HistorySelected")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    } else {
                        Image("HistoryDeselect")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                    Text("History")
                        .fontWeight(selectedTab == .history ? .bold : .regular)
                        .font(.footnote)
                        .foregroundColor(Color.theme.grayPrimary)
                } // END: VSTACK
            }) // END: LABEL & BUTTON HISTORY
            .padding(.bottom)
            .padding(.trailing)
            .buttonStyle(TabButtonStyle())
        } // END: HSTACK
        .padding()
        .frame(height: 100)
        .background(Color.theme.primary)
        .cornerRadius(15)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selectedTab: .constant(.checkin))
            .previewLayout(.sizeThatFits)
    }
}

// MARK: - TAB BUTTON STYLE EFFECT
struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}
