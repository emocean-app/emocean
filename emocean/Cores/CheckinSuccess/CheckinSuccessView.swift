//
//  CheckinSuccessView.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import SwiftUI
import Lottie

struct CheckinSuccessView: View {
    @State var showAlert: Bool = false
    @State var setReminder: Bool = false
    let time = Time()
    @State var selected: Int = 0
    var body: some View {
        ZStack {
            LottieView(filename: "\(time.getRawValue())Ending", contentMode: .scaleAspectFit).ignoresSafeArea(edges: .top)
            ScrollView {
                TabView(selection: $selected) {
                    Page1(theme: time.getRawValue()).tag(0)
                    Page2(theme: time.getRawValue()).tag(1)
                }
                .frame(
                    width: UIScreen.main.bounds.width ,
                    height: UIScreen.main.bounds.height
                )
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
                .animation(.easeInOut(duration: 90))
            }.edgesIgnoringSafeArea(.all)

            if selected == 1 {
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    PrimaryButton(content: {
                        Text("Thanks!")
                    }, maxWidth: 100, action: {
                        showAlert.toggle()
                    })
                    .alert(isPresented: $showAlert, content: {
                        getAllert()
                    })
                    Spacer()
                }
            }
        }.ignoresSafeArea()
    }
    
    
    func getAllert() -> Alert {
        return Alert(
            title: Text("Want to get reminded for \n your daily Check-In?"),
            message: Text("You can change the reminder on settings"),
            primaryButton: .default(Text("No thanks")),
            secondaryButton: .default(Text("Sure"), action: {
                alertView()
            })
        )
    }
    
    func alertView(){
        let alert = UIAlertController(title: "You’re all set!", message: "you will be reminded every night!", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default) { (_) in
            return
        }
        alert.addAction(okay)
        
        //presenting alert
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
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
            Image("L\(theme)")
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
