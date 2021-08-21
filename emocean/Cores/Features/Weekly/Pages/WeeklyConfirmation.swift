//
//  WeeklyConfirmation.swift
//  emocean
//
//  Created by Wilson Adrilia on 16/08/2021.
//

import SwiftUI
import Lottie

struct WeeklyConfirmation: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    
    let time = Time()
    @State var selected: Int = 0
    var body: some View {
        contentContainer
        .preferredColorScheme(time.timeRange == .night ? .dark : .light)
    }
}

extension WeeklyConfirmation {
    var contentContainer: some View {
        VStack {
            Spacer()
            Text("Do you want to keep \n on your goal?")
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                PrimaryButton(content: {
                    Text("No")
                }, maxWidth: 100, action: {
                    showAction.toggle()
                })
                .animation(.easeInOut(duration: 4))
                .actionSheet(isPresented: $showAction, content: getActionSheet)
                PrimaryButton(content: {
                    Text("Yes")
                }, maxWidth: 100, action: {
                    showAction.toggle()
                })
            }
        }
    }
    func getActionSheet() -> ActionSheet {
         let firstButton: ActionSheet.Button = .default(Text("Cancel")) {
             
         }
         let secondButton: ActionSheet.Button = .destructive(Text("Confirm")) {
             presentationMode.wrappedValue.dismiss()
         }
         let thirdButton: ActionSheet.Button = .cancel()
         return ActionSheet(
             title: Text("Are you sure?"),
             message: Text("Your goal will be deleted"),
             buttons: [firstButton,secondButton,thirdButton]
         )
     }
}

struct WeeklyConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyConfirmation()
    }
}
