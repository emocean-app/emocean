//
//  WeeklyConfirmation.swift
//  emocean
//
//  Created by Wilson Adrilia on 16/08/2021.
//

import SwiftUI
import Lottie

struct WeeklyConfirmation: View {
    // MARK: ENVIRONMENT
    @Environment(\.presentationMode) var presentationMode
    // MARK: PROPERTIES
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    @State var selected: Int = 0
    let time = Time()
    // MARK: BODY
    var body: some View {
        // - CONTENT
        contentContainer
            .preferredColorScheme(time.timeRange == .night ? .dark : .light)
    }
}

// MARK: - COMPONENTS

extension WeeklyConfirmation {
    var contentContainer: some View {
        VStack { // START: VSTACK
            Spacer()
            // - TEXT
            Text("Do you want to keep \n on your goal?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer()
            HStack { // START: HSTACK
                // - NO BUTTON
                PrimaryButton(content: {
                    Text("No")
                }, maxWidth: 100, action: {
                    showAction.toggle()
                })
                .animation(.easeInOut(duration: 4))
                .actionSheet(
                    isPresented: $showAction,
                    content: getActionSheet
                )
                // - YES BUTTON
                PrimaryButton(content: {
                    Text("Yes")
                }, maxWidth: 100, action: {
                    showAction.toggle()
                })
            } // END: HSTACK
        } // END: VSTACK
    }
}

// MARK: - METHODS
extension WeeklyConfirmation {
    func getActionSheet() -> ActionSheet {
        // Define Cancel button for alert
        let firstButton: ActionSheet.Button = .default(Text("Cancel")) {
            print("Cancel")
        }
        // Define Confirm Button for alert
        let secondButton: ActionSheet.Button = .destructive(Text("Confirm")) {
            presentationMode.wrappedValue.dismiss()
        }
        // Define cancel button for alert
        let thirdButton: ActionSheet.Button = .cancel()
        // Return the ActionSheet
        return ActionSheet(
            title: Text("Are you sure?"),
            message: Text("Your goal will be deleted"),
            buttons: [firstButton,secondButton,thirdButton]
        )
    }
}

// MARK: - PREVIEW
struct WeeklyConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyConfirmation()
    }
}
