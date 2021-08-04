//
//  CheckinFeelingsView.swift
//  emocean
//
//  Created by Wilson Adrilia on 03/08/2021.
//

import SwiftUI

struct CheckinFeelingsView: View {
    @State var question: String = "How do you feel?"
    @State var selection: String = "Select Time"
    @State var energy: CGFloat = 0.0
    @State var pleasentness: CGFloat = 0.0
    
    @State var name: String = "Annoyed"
    @State var description: String = "Feeling or showing angry irritation or anything that makes you angry"
    @State var image: String = ""
    
    var array: [String] = ["This Morning", "This Afternoon", "This Evening", "This Night"]
    
    let timer = Timer.publish(every: 1.25, on: .main, in: .common).autoconnect()
    @State private var animationOffset = false
    
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack{ // START: ZSTACK
//            Rectangle()
//                .fill(
//                    LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom)
//                )
//                .ignoresSafeArea()
            GeometryReader {reader in
                // background
                EMTheme.shared.sea
                    .ignoresSafeArea()
                
                // back coral
                backCoral
                
                // front coral
                frontCoral
                
                let normalOffset = 0-reader.safeAreaInsets.top
                let animateoffset = 0 - reader.safeAreaInsets.top - 30
                
                ZStack {
                    // fish rod
                    VStack { // START: VSTACK
                        HStack { // START: HSTACK
                            Spacer()
                            Image("FishRod")
                                .resizable()
                                .frame(
                                    width: reader.size.width * 0.1,
                                    height: reader.size.height * 0.4
                                )
                                .offset(
                                    x: 0,
                                    y: animationOffset ? animateoffset : normalOffset
                                )
                        } // START: HSTACK
                        .padding(.trailing, 50)
                        Spacer()
                    } // END: VSTACK
                    .ignoresSafeArea()
                    
                    // content
                    contentContainer
                }
                .frame(minHeight: reader.size.height)
            }

        }
    }
}
// MARK: - COMPONENTS
extension CheckinFeelingsView{
    
    var contentContainer: some View {
        VStack{ // START: VSTACK
            Group{ // START: GROUP
                HStack{ // START: HSTACK
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.system(size: 27.0, weight: .medium))
                        .frame(maxWidth: 30, maxHeight: 30, alignment: .center)
                        .foregroundColor(Color.white)
                } // END: HSTACK
                .padding(.horizontal,25)
                Spacer().frame(minHeight: 10, maxHeight: 20)
                Text(question)
                    .font(.system(size: 28.0, weight: .semibold))
                    .foregroundColor(Color.white)

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
                Image("Crab")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 170, height: 120)
                    .offset(y: animationOffset ? 8.0 : -0.8)
                    .onReceive(timer, perform: { _ in
                        withAnimation(.easeInOut(duration: 1.25)) {
                            animationOffset.toggle()
                        }
                    })
                Text(name).font(.system(size: 27.0, weight: .semibold)).italic()
                    .foregroundColor(Color.white)
                Spacer().frame(minHeight: 10, maxHeight: 10)
                Text(description).font(.system(size: 15.0, weight: .regular))
                    .foregroundColor(Color.white).frame(maxWidth: 325, alignment: .center).multilineTextAlignment(.center)
            }
            Group {
                VStack(alignment: .leading){
                    Spacer()
                        .frame(minHeight: 10, maxHeight: 50)
                    HStack{
                        Text("Energy")
                        .font(.system(size: 17.0, weight: .regular))
                        .foregroundColor(Color.white).padding(.horizontal, 10)
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 12.0))
                            .foregroundColor(Color.white)
                            .padding(.horizontal,-12)
                    }
                    Spacer().frame(minHeight: 1, maxHeight: 1)
                    CustomControl(text: $energy)
                        .frame(width: 325, height: 50, alignment: .center)
                    Spacer().frame(minHeight: 10, maxHeight: 30)
                    HStack{
                        Text("Pleasentness")
                        .font(.system(size: 17.0, weight: .regular))
                        .foregroundColor(Color.white).padding(.horizontal, 10)
                        Image(systemName: "questionmark.circle")
                            .font(.system(size: 12.0))
                            .foregroundColor(Color.white)
                            .padding(.horizontal,-12)
                    }
                    Spacer()
                        .frame(minHeight: 1, maxHeight: 1)
                    CustomControl(text: $pleasentness)
                        .frame(width: 325, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
            Group {
                VStack(alignment: .center){
                    // Button
                    
                    PrimaryButton(content: {
                        Text("I do feel that!")
                    }, maxWidth: 177){
                        print("Primary Button Clicked")
                    }
                }
            }
        }
    }
    
    var fishRod: some View {
        VStack { // START: VSTACK
            HStack { // START: HSTACK
                Spacer()
                Image("FishRod")
                    .resizable()
                    .frame(
                        width: 44,
                        height: 350
                    )
                    .offset(
                        x: 0,
                        y: animationOffset ? -30 : 0
                    )
            } // START: HSTACK
            .padding(.trailing, 50)
            Spacer()
        } // END: VSTACK
        .ignoresSafeArea()
    }
    
    var backCoral: some View {
        VStack(alignment: .trailing) {
            Spacer()
            Image("BackCoral")
                .resizable()
                .frame(
                    width: imageFullWidth,
                    height: 275,
                    alignment: .leading
                )
                
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .ignoresSafeArea()
    }
    
    var frontCoral: some View {
        VStack(alignment: .trailing) {
            Spacer()
            Image("FrontCoral")
                .resizable()
                .frame(
                    width: imageFullWidth,
                    height: 300,
                    alignment: .leading
                )
                
        }
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct CheckinFeelingsView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinFeelingsView()
    }
}

