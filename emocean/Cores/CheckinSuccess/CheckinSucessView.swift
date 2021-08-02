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
        //        ZStack{
        //            Rectangle()
        //                .fill(
        //                    LinearGradient(gradient: Gradient(colors: [Color.theme.sunsetTopGradient, Color.theme.sunsetBottomGradient]), startPoint: .top, endPoint: .bottom)
        //                )
        //                .ignoresSafeArea()
        //            VStack {
        //                ScrollView(.horizontal){
        //                    HStack{
        //                        Image("SunsetEnd")
        //                            .resizable()
        //                            .scaledToFill()
        //                            .ignoresSafeArea()
        //                    }.ignoresSafeArea()
        //                }
        //            }
        //
        //            TabView(){
        //                Text("HELLO")
        //                Text("HELLOoooo")
        //            }
        //            .tabViewStyle(PageTabViewStyle())
        //            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        //        }
    }
}


struct CheckinSucessView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinSucessView()
    }
}

//struct Test: View {
//    var body: some View {
//        Group{
//            Rectangle()
//                .fill(
//                    LinearGradient(gradient: Gradient(colors: [Color.theme.sunsetTopGradient, Color.theme.sunsetBottomGradient]), startPoint: .top, endPoint: .bottom)
//                )
//                .ignoresSafeArea()
//            VStack{
//                Image("SunsetEnd")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//            }
//        }
//    }
//}
//
struct Page1: View {
    var body: some View {
        VStack (alignment: .leading){
            Spacer()
            Text("Thank you for Sharing your thoughts with me!")
                .font(.title2)
                .fontWeight(.medium)
                .frame(width: 250)
                .padding(.leading)
            Spacer()
            Image("test1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFit()
        }.ignoresSafeArea()
    }
}
struct Page2: View {
    var body: some View {
        VStack (alignment: .leading) {
            Spacer()
            Text("“Do what you can, with what you’ve got, where you are.”")
                .font(.title2)
                .fontWeight(.medium)
                .frame(width: 250)
                .padding(.leading)
            Spacer()
            Image("test2")
                .resizable()
                .ignoresSafeArea()
                .scaledToFit()
            
        }
    }
}

