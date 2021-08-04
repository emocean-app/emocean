//
//  CheckinCategoryView.swift
//  emocean
//
//  Created by Puras Handharmahua on 27/07/21.
//

import SwiftUI

struct CheckinCategoryView: View {
    // MARK: PROPERTIES
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    let timer = Timer.publish(every: 1.25, on: .main, in: .common).autoconnect()
    @State private var animationOffset = false
    
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZSTACK
            GeometryReader {reader in
                // background
                EMTheme.shared.sea
                    .ignoresSafeArea()
                
                // back coral
                backCoral
                
                // front coral
                frontCoral
                
                // content
                ScrollView {
                    
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
            
        } // END: ZSTACK
    }
}

// MARK: - COMPONENTS

extension CheckinCategoryView {
    
    var contentContainer: some View {
        VStack { // START: VSTACK
            // Question
            questionSection
            Spacer(minLength: 35)
            
            // Image
            Image("jellyfish")
                .resizable()
                .scaledToFit()
                .frame(width: 170, height: 120)
                .offset(y: animationOffset ? 8.0 : -0.8)
                .onReceive(timer, perform: { _ in
                    withAnimation(.easeInOut(duration: 1.25)) {
                        animationOffset.toggle()
                    }
                })
            Spacer(minLength: 35)
            
            // Grid
            categorySection
            
            // Button
            PrimaryButton(content: {
                Text("Yes!")
            }, maxWidth: 177) {
                print("Primary Button Clicked")
            }
        } // END: VSTACK
    }
    
    var questionSection: some View {
        VStack { // START: VSTACK
            Text("Please, tell me")
            Text("what made you")
                .bold()
                .italic()
            Text("feel sad?")
                .bold()
                .italic()
        } // END: VSTACK
        .font(.title)
        .foregroundColor(Color.white)
        .padding(.top, 30)
    }
    
    var categorySection: some View {
        TabView { // START: TABVIEW
            ForEach(0..<3) { _ in // START: FOREACH
                VStack { // START: VSTACK
                    LazyVGrid(columns: columns, spacing: 20, content: { // START: VGRID
                        ForEach(0..<8) { _ in // START: FOREACH
                            ButtonOutlined(
                                text: "Title",
                                isSelected: .constant(false)
                            )
                            .padding(.horizontal, 5)
                        } // END: FOREACH
                    }) // END: VGRID
                    .padding(.top, 5)
                    Spacer()
                } // END: VSTACK
            } // END: FOREACH
        } // END: TABVIEW
        .tabViewStyle(PageTabViewStyle())
        .padding(.horizontal, 25)
        .overlay( // START: OVERLAY
                VStack() { // START: VSTACK
                    Spacer()
                    Text("You can choose up to 3")
                        .foregroundColor(.white)
                        .font(.subheadline)
                    Spacer()
                        .frame(height: 37.5)
                } // END: VSTACK
                .frame(width: .infinity)
        ) // START: OVERLAY
        .frame(height: 370)
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
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
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
        .frame(width: UIScreen.main.bounds.width, alignment: .center)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW

struct CheckinCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinCategoryView()
    }
}
