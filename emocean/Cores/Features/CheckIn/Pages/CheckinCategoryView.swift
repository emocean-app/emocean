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
    let timer = Timer.publish(every: 1.25, on: .main, in: .common).autoconnect()
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    // MARK: BODY
    var body: some View {
        GeometryReader {reader in // START: GEO
            // content
            ScrollView { // START: SCROLLVIEW
                let normalOffset = 0-reader.safeAreaInsets.top
                let animateoffset = 0 - reader.safeAreaInsets.top - 30
                ZStack { // START: ZSTACK
                    // Fish Rod Image
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
                    // Content
                    contentContainer
                } // END: ZSTACK
                .frame(minHeight: reader.size.height)
            } // END: SCROLLVIEW
        } // START: SCROLLVIEW
    }
}

// MARK: - COMPONENTS
extension CheckinCategoryView {
    // CONTENT
    var contentContainer: some View {
        VStack { // START: VSTACK
            // Question
            questionSection
            Spacer(minLength: 35)
            // Image
            Image(env.getMoodImage())
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
            PrimaryButton(content: { // START: BUTTON
                Text("Yes!")
            }, maxWidth: 177) {
                print("Primary Button Clicked")
                withAnimation(.easeInOut(duration: 1)) {
                    if env.checkin.categoryId != 0 {
                        env.goToNextStep()
                    }
                }
            } // END: BUTTON
        } // END: VSTACK
    }
    // QUESTION
    var questionSection: some View {
        VStack { // START: VSTACK
            Text(env.getQuestion())
                .bold()
                .frame(maxWidth: UIScreen.main.bounds.width * 0.7)
                .multilineTextAlignment(.center)
        } // END: VSTACK
        .font(.title)
        .foregroundColor(Color.white)
        .padding(.top, 30)
    }
    // CATEGORY
    var categorySection: some View {
        TabView { // START: TABVIEW
            ForEach(0..<3) { page in // START: FOREACH
                VStack { // START: VSTACK
                    LazyVGrid(columns: columns, spacing: 20, content: { // START: VGRID
                        ForEach(0..<8) { item in // START: FOREACH
                            let idx = item + (8*page)
                            let model = env.categories[idx]
                            ButtonOutlined(
                                text: model.name,
                                isSelected: env.checkIfSelected(model: model),
                                action: {
                                    env.categoryClicked(model: model)
                                }
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
        .frame(height: 370)
    }
}

// MARK: - PREVIEW
struct CheckinCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinCategoryView()
            .background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
