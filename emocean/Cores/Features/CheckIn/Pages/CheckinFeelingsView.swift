//
//  CheckinFeelingsView.swift
//  emocean
//
//  Created by Wilson Adrilia on 03/08/2021.
//
import SwiftUI

struct CheckinFeelingsView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var env: CheckinViewModel
    @State var selection: TimeRange = Time().timeRange
    @State var energy: CGFloat = 0.5
    @State var pleasentness: CGFloat = 0.5
    var getEnergy: Int {
        return getValue(energy)
    }
    var getPleasentness: Int {
        return getValue(pleasentness)
    }
    let timer = Timer.publish(every: 1.25, on: .main, in: .common).autoconnect()
    @State private var animationOffset = false
    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height
    private let time = Time()
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZSTACK
            GeometryReader {reader in
                let normalOffset = 0-reader.safeAreaInsets.top
                let animateoffset = 0 - reader.safeAreaInsets.top - 30

                ZStack { // START: VSTACK
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
                } // END: VSTACK
                .frame(minHeight: reader.size.height)
            }
        }
    }
}
// MARK: - COMPONENTS
extension CheckinFeelingsView {
    // Content
    var contentContainer: some View {
        VStack { // START: VSTACK
            Group { // START: GROUP
                Spacer().frame(minHeight: 10, maxHeight: 20)
                Text(env.getQuestion())
                    .font(.system(size: 28.0, weight: .semibold))
                    .foregroundColor(Color.white)
                Text("This \(time.getRawValue())")
                    .font(.system(size: 28.0, weight: .semibold))
                    .foregroundColor(Color.white)
                Spacer(minLength: 50)
                Image(env.getMoodImage(energy: getEnergy, pleasent: getPleasentness))
                    .resizable()
                    .scaledToFit()
                    .frame( height: 120)
                    .offset(y: animationOffset ? 8.0 : -0.8)
                    .onReceive(timer, perform: { _ in
                        withAnimation(.easeInOut(duration: 1.25)) {
                            animationOffset.toggle()
                        }
                    })
                Spacer(minLength: 20)
                Text(env.getMoodName(energy: getEnergy, pleasent: getPleasentness))
                    .font(.system(size: 27.0, weight: .semibold))
                    .italic()
                    .foregroundColor(Color.white)
                    .animation(.easeInOut)
                    .frame(minHeight: 35)
                Spacer().frame(minHeight: 10, maxHeight: 10)
                Text(
                    env.getMoodDescription(energy: getEnergy, pleasent: getPleasentness)
                )
                    .font(.system(size: 15.0, weight: .regular))
                    .foregroundColor(Color.white)
                .frame(maxWidth: 325, minHeight: 70, alignment: .top)
                    .multilineTextAlignment(.center)
                    .transition(.opacity)
            }
            Group {
                VStack(alignment: .leading) { // START: VSTACK
                    Spacer()
                        .frame(height: 5)
                    HStack { // START: HSTACK
                        Text("Energy")
                        .font(.system(size: 17.0, weight: .regular))
                        .foregroundColor(Color.white).padding(.horizontal, 10)

                        Menu {
                            Button(action: {}, label: {
                                Text("Are you feeling sluggish or more energetic?")
                            })
                        } label: {
                            Label("", systemImage: "questionmark.circle")
                                .font(.system(size: 12.0))
                                .foregroundColor(Color.white)
                        }
                        .padding(.horizontal,-12)
                    } // END: HSTACK
                    Spacer().frame(minHeight: 1, maxHeight: 1)
                    CustomControl(text: $energy)
                        .frame(width: 325, height: 50, alignment: .center)
                    Spacer().frame(minHeight: 10, maxHeight: 30)
                    HStack { // START: HSTACK
                        Text("Pleasantness")
                        .font(.system(size: 17.0, weight: .regular))
                        .foregroundColor(Color.white).padding(.horizontal, 10)

                        Menu {
                            Button(action: {}, label: {
                                Text("Are you feeling unpleasant or pleasant")
                            })
                        } label: {
                            Label("", systemImage: "questionmark.circle")
                                .font(.system(size: 12.0))
                                .foregroundColor(Color.white)
                        }
                        .padding(.horizontal,-12)
                    } // END: HSTACK
                    Spacer()
                        .frame(minHeight: 1, maxHeight: 1)
                    CustomControl(text: $pleasentness)
                        .frame(width: 325, height: 50, alignment: .center)
                    Spacer()
                } // END: VSTACK
            }
            Group { // START: GROUP
                VStack(alignment: .center) { // START: VSTACK
                    // Button
                    PrimaryButton(content: { // START: BUTTON
                        Text("I do feel that!")
                    }, maxWidth: 177) {
                        print("Primary Button Clicked")
                        withAnimation(
                            .easeInOut(duration: 0.5)
                        ) {
                            guard let mood = env.getMood(energy: getEnergy, pleasent: getPleasentness) else {return}
                            env.setMood(mood: mood)
                            env.goToNextStep(isYes: true)
                        }
                    } // END: BUTTON
                } // END: H\VSTACK
            } // END: GROUP
        }
    }
    // Fish Rod
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

// MARK: - METHODS
extension CheckinFeelingsView {
    private func getValue(_ float: CGFloat) -> Int {
        switch float {
        case 0...0.10:
            return 1
        case 0.10...0.20:
            return 2
        case 0.20...0.30:
            return 3
        case 0.30...0.40:
            return 4
        case 0.40...0.49:
            return 5
        case 0.49...0.51:
            return 0
        case 0.51...0.60:
            return 6
        case 0.60...0.70:
            return 7
        case 0.70...0.80:
            return 8
        case 0.80...0.90:
            return 9
        case 0.90...1:
            return 10
        default:
            return 0
        }
    }
}

// MARK: - PREVIEW
struct CheckinFeelingsView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinFeelingsView()
            .background(EMTheme.shared.sea.ignoresSafeArea())
            .environmentObject(CheckinViewModel())
    }
}
