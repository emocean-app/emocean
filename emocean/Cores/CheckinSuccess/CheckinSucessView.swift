//
//  CheckinSucessView.swift
//  emocean
//
//  Created by Christian Adiputra on 31/07/21.
//

import SwiftUI

struct CheckinSucessView: View {
    @State var selected: Int = 0
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.theme.sunsetTopGradient, Color.theme.sunsetBottomGradient]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
            TabView(selection: $selected){
                Page1().tag(0)
                Page2().tag(1)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
            .ignoresSafeArea()
            
            
            
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


struct CheckinSucessView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinSucessView()
    }
}

struct Page1: View {
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
            
            Image("LMorning")
                .resizable()
                .scaledToFill()
        }
    }
}
struct Page2: View {
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
            Image("RMorning")
                .resizable()
                .scaledToFill()
        }
    }
}

