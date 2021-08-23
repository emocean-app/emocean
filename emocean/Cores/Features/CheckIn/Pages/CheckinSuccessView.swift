//
//  CheckinSuccessView.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//
import SwiftUI
import Lottie

struct CheckinSuccessView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var env: CheckinViewModel
    @EnvironmentObject var settingsEnv: SettingsViewModel
    @State var showAlert: Bool = false
    @State var showAction: Bool = false
    @State var isfirst: Bool = true
    let time = Time()
    @State var selected: Int = 0
    var body: some View {
        ZStack {
            LottieView(filename: "\(time.getRawValue())Ending", contentMode: .scaleAspectFit).ignoresSafeArea()
            Page1(theme: time.getRawValue()).ignoresSafeArea()
                VStack {
                    Spacer().frame(height: UIScreen.main.bounds.height * 0.8)
                    PrimaryButton(content: {
                        Text("Thanks!")
                    }, maxWidth: 100, action: {
                        print(env.checkin.asDictionary)
                        env.addCheckin()
                        if UserDefaults.standard.object(forKey: "isFirstNotification") == nil,
                           !settingsEnv.reminder {
                            showAction.toggle()
                        } else {
                            presentationMode.wrappedValue.dismiss()
                        }
                    })
                    .animation(.easeInOut(duration: 4))
                    .actionSheet(isPresented: $showAction, content: getActionSheet)
                    .alert(isPresented: $showAlert, content: {
                        getAllert()
                    })
                    Spacer()
                }
        }
    }
    
    func getActionSheet() -> ActionSheet {
        
        let button1: ActionSheet.Button = .default(Text("Sure")){
            showAlert.toggle()
        }
        let button2: ActionSheet.Button = .destructive(Text("No thanks!")){
            presentationMode.wrappedValue.dismiss()
        }
        let button3: ActionSheet.Button = .cancel()
        return ActionSheet(
            title: Text("Want to get reminded for \n your daily Check-In?"),
            message: Text("You can change the reminder on settings"),
            buttons: [button1,button2,button3]
        )
    }

    func getAllert() -> Alert {
        return Alert(
            title: Text("You’re all set!"),
            message: Text("you will be reminded every night!"),
            dismissButton: .default(Text("Okay"), action: {
            self.isfirst = false
            presentationMode.wrappedValue.dismiss()})
        )
    }
}

struct CheckinSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinSuccessView()
    }
}

struct Page1: View {
    let theme: String
    var body: some View {
        ZStack{
            Image("Ending\(theme)")
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading){
                Spacer()
                Text("Thank you for sharing your thoughts with me!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 300)
                    .padding(.leading,0)
                Spacer()
                Spacer()
            }.padding(.trailing, 30)
            .foregroundColor(theme == "Night" ? .white : .primary)
        }
    }
}

struct Page2: View {
    let theme: String
    var body: some View {
        ZStack{
            Image("R\(theme)")
                .resizable()
                .scaledToFill()
            VStack(alignment: .leading, spacing: 20){
                Spacer()
                Text("“Do what you can, with what you’ve got, where you are.”")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 300)
                    .padding(.leading,0)
                Text("—Theodore Roosevelt")
                Spacer()
                Spacer()
            }
            .padding(.trailing, 30)
            .foregroundColor(theme == "Night" ? .white : .primary)
        }
    }
}

enum ThemeBG: String {
    case morning = "Morning"
    case noon = "Noon"
    case sunset = "Sunset"
    case night = "Night"
}
