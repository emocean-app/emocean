//
//  CheckinFeelingsView.swift
//  emocean
//
//  Created by Wilson Adrilia on 03/08/2021.
//

import SwiftUI

struct CheckinFeelingsView: View {
    @Binding var question: String
    @State var selection: String = "Select Time"
    
    @Binding var name: String
    @Binding var description: String
    @State var image: String = ""
    
    var array: [String] = ["This Morning", "This Afternoon", "This Evening", "This Night"]
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(
                    LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom)
                )
                .ignoresSafeArea()
            VStack{
                HStack{
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 27.0, weight: .medium))
                        .frame(maxWidth: 30, maxHeight: 30, alignment: .center)
                        .foregroundColor(Color.theme.grayPrimary)
                }
                .padding(.horizontal,25)
                Spacer().frame(minHeight: 10, maxHeight: 20)
                Text(question)
                    .font(.system(size: 28.0, weight: .semibold))
                    .foregroundColor(Color.theme.grayPrimary)

                HStack{
                    Picker(selection: $selection, label: HStack{
                        Text(selection)
                        Image(systemName: "chevron.down")
                    }, content: {
                        ForEach(array, id: \.self) { word in
                            Text(word).tag(word)
                        }
                    })
                .frame(width: 150, height: 5)
                .animation(nil)
                .pickerStyle(MenuPickerStyle())
                .padding()
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.white, lineWidth: 2)
                ).background(RoundedRectangle(cornerRadius: 30).fill(Color.clear))
                }
                Spacer().frame(minHeight: 10, maxHeight: 20)
                Image("Crab").resizable()
                    .frame(width: 170, height: 140, alignment: .center)
                Text(name).font(.system(size: 27.0, weight: .semibold)).italic()
                    .foregroundColor(Color.theme.grayPrimary)
                Spacer().frame(minHeight: 10, maxHeight: 10)
                Text(description).font(.system(size: 15.0, weight: .regular))
                    .foregroundColor(Color.theme.grayPrimary).frame(alignment: .center)
                Spacer()
            }
        }
    }
}

struct CheckinFeelingsView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinFeelingsView(question: .constant("How do you feel?"), name: .constant("Annoyed"), description: .constant("feeling or showing angry irritation"))
    }
}

