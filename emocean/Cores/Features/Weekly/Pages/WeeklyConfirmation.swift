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
    @EnvironmentObject var env: WeeklyViewModel
    // MARK: PROPERTIES
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    @State var selected: Int = 0
    let time = Time()
    private var model: ThirdWeeklyCheckinStep
    // MARK: INIT
    init(model: WeeklyCheckinStep) {
        guard let model = model as? ThirdWeeklyCheckinStep else {
            self.model = ThirdWeeklyCheckinStep(
                id: 0,
                backgroundType: .sky,
                next: 0,
                nextSecondary: 0,
                text: "Error Casting"
            )
            return
        }
        self.model = model
    }
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
            Text(model.text)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer()
            HStack { // START: HSTACK
                // Selection whether show two button or just one button
                if model.selection {
                    // - TWO BUTTON
                    twoButton
                } else {
                    oneButton
                }
            } // END: HSTACK
        } // END: VSTACK
    }
    // OKAY BUTTON
    var oneButton: some View {
        // - OKAY BUTTON
        PrimaryButton(content: {
            Text("Okay")
        }, maxWidth: 100, action: {
            print("Selesai")
            presentationMode.wrappedValue.dismiss()
        })
        .animation(.easeInOut(duration: 4))
        .transition(.move(edge: .bottom))
    }
    // YES NO BUTTON
    var twoButton: some View {
        Group {
            // - NO BUTTON
            PrimaryButton(content: {
                Text("No")
            }, maxWidth: 100, action: {
                // Check if the model is the last step
                if model.isLast {
                    // Show sheet
                    showAction.toggle()
                } else {
                    // Go to next step
                    env.goToNextStep(id: model.nextSecondary)
                }
            })
            .animation(.easeInOut)
            .actionSheet(
                isPresented: $showAction,
                content: getActionSheet
            )
            // - YES BUTTON
            PrimaryButton(content: {
                Text("Yes")
            }, maxWidth: 100, action: {
                // Check if the model is the last step
                if model.isLast {
                    // Show sheet
                    showAction.toggle()
                } else {
                    // Go to next step
                    env.goToNextStep(id: model.next)
                }
            })
            .animation(.easeInOut)
        }
    }
}

// MARK: - METHODS

extension WeeklyConfirmation {
    func getActionSheet() -> ActionSheet {
        // Define Cancel button for alert
        let firstButton: ActionSheet.Button = .default(Text("Cancel")) {
            print("Cancel")
            presentationMode.wrappedValue.dismiss()
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
        let viewModel = WeeklyViewModel()
        WeeklyConfirmation(model: viewModel.currentStep)
            .environmentObject(viewModel)
    }
}
