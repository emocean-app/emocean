//
//  CheckinCategoryView.swift
//  emocean
//
//  Created by Puras Handharmahua on 27/07/21.
//
import SwiftUI

struct CheckinCategoryView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var env: CheckinViewModel
    @State private var animationOffset = false
    @StateObject private var vm = CheckinCategoryViewModel()
    
    let timer = Timer.publish(every: 1.25, on: .main, in: .common).autoconnect()
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZSTACK
            GeometryReader {reader in
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
            Image("Jellyfish")
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
                withAnimation(.easeInOut(duration: 0.5)) {
                    env.goToNextStep(isYes: true)
                }
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
            ForEach(0..<3) { i in // START: FOREACH
                VStack { // START: VSTACK
                    LazyVGrid(columns: columns, spacing: 20, content: { // START: VGRID
                        ForEach(0..<8) { j in // START: FOREACH
                            let idx = j + (8*i)
                            ButtonOutlined(
                                text: vm.categories[idx].name,
                                isSelected: false
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
                .frame(width: UIScreen.main.bounds.width)
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
}

// MARK: - PREVIEW
struct CheckinCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinCategoryView()
            .background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
