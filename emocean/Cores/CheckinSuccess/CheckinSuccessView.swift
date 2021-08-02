//
//  CheckinSuccessView.swift
//  emocean
//
//  Created by Christian Adiputra on 02/08/21.
//

import SwiftUI

struct CheckinSuccessView: View {
    @State var skybg: String = SkyBG.morning.rawValue
    @State var theme: String = ThemeBG.morning.rawValue
    @State var selected: Int = 0
    var body: some View {
        ZStack{
            LottieView(filename: skybg)
                .ignoresSafeArea()
            TabView(selection: $selected){
                Page1(theme: $theme).tag(0).animation(.easeIn)
                Page2(theme: $theme).tag(1).animation(.easeInOut(duration: 100))
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
            .ignoresSafeArea()
//            .animation(.easeInOut(duration: 90))

            if selected == 1 {
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    PrimaryButton(content: {
                        Text("Thanks!")
                    }, maxWidth: 100, action: {})
                    Spacer()
                }
            }
        }
    }
}

struct CheckinSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinSuccessView()
    }
}

struct Page1: View {
    @Binding var theme: String
    var body: some View {
        ZStack{
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
            
            Image("L\(theme)")
                .resizable()
                .scaledToFill()
        }
    }
}
struct Page2: View {
    @Binding var theme: String
    var body: some View {
        ZStack{
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
            Image("R\(theme)")
                .resizable()
                .scaledToFill()
        }
    }
}

enum SkyBG: String {
    case morning = "MorningEnding"
    case noon = "NoonEnding"
    case sunset = "SunsetEnding"
    case night = "NightEnding"
}

enum ThemeBG: String {
    case morning = "Morning"
    case noon = "Noon"
    case sunset = "Sunset"
    case night = "Night"
}
