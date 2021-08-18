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
    
    @EnvironmentObject var env: CheckinViewModel
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    let time = Time()
    @State var selected: Int = 0
    var body: some View {
        ZStack {
            LottieView(filename: "\(time.getRawValue())Ending", contentMode: .scaleAspectFit).ignoresSafeArea(edges: .top)
            Image("R\(time.getRawValue())")
                .resizable()
                .scaledToFill()
            VStack {
                Spacer()
                Spacer().frame(height:100)
                Text("Do you want to keep \n on your goal?").font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                Spacer()
                
                HStack {
                    PrimaryButton(content: {
                        Text("No")
                    }, maxWidth: 100, action: {
                        print(env.checkin.feedbacks)
                        showAction.toggle()
                    })
                    .animation(.easeInOut(duration: 4))
                    .actionSheet(isPresented: $showAction, content: getActionSheet)
                    .alert(isPresented: $showAlert, content: {
                    getAllert()
                    })
                    PrimaryButton(content: {
                        Text("Yes")
                    }, maxWidth: 100, action: {
                        print(env.checkin.feedbacks)
                        showAction.toggle()
                    })
                }
                Spacer().frame(height: 50)
            }
        }.ignoresSafeArea()
//        .foregroundColor(theme == "Night" ? .white : .primary)
    }
    func getActionSheet() -> ActionSheet {
        
        let button1: ActionSheet.Button = .default(Text("Confirm")){
            showAlert.toggle()
        }
        let button2: ActionSheet.Button = .destructive(Text("Cancel")){
            presentationMode.wrappedValue.dismiss()
        }
        let button3: ActionSheet.Button = .cancel()
        return ActionSheet(
            title: Text("Are you sure?"),
            message: Text("Your goal will be deleted"),
            buttons: [button1,button2,button3]
        )
    }

    func getAllert() -> Alert {
        return Alert(
            title: Text("You’re all set!"),
            message: Text("you will be reminded every night!"),
            dismissButton: .default(Text("Okay"), action: {
            presentationMode.wrappedValue.dismiss()})
        )
    }
    
    func alertView() {
        let alert = UIAlertController(title: "You’re all set!", message: "you will be reminded every night!", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default) { (_) in
            return
        }
        alert.addAction(okay)
        
        //presenting alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            presentationMode.wrappedValue.dismiss()
        })
    }
}

struct WeeklyConfirmation_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyConfirmation()
    }
}
