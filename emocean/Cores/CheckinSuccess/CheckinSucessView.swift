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
            VStack {
                ScrollView(.horizontal){
                    HStack{
                        Image("SunsetEnd")
                            .resizable()
                            .scaledToFill()
                            .ignoresSafeArea()
                    }.ignoresSafeArea()
                }
            }
            
            TabView(){
                Text("HELLO")
                Text("HELLOoooo")
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
            .frame(width: 400, height: 200, alignment: .leading)
        }
    }
}


struct CheckinSucessView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinSucessView()
    }
}

struct Test: View {
    var body: some View {
        Group{
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.theme.sunsetTopGradient, Color.theme.sunsetBottomGradient]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
            VStack{
                Image("SunsetEnd")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
        }
    }
}
