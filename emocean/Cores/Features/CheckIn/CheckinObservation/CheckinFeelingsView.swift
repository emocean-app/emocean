//
//  CheckinFeelingsView.swift
//  emocean
//
//  Created by Wilson Adrilia on 03/08/2021.
//
import SwiftUI

struct CheckinFeelingsView: View {
    @EnvironmentObject var env: CheckinViewModel
    @State var question: String = "How do you feel?"
    @State var selection: TimeRange = Time().timeRange
    @State var energy: CGFloat = 0.5
    @State var pleasentness: CGFloat = 0.5
    var getEnergy: Int {
        if 0 ... 0.10 ~= energy { return 1 }
        else if 0.10 ... 0.20 ~= energy { return 2 }
        else if 0.20 ... 0.30 ~= energy { return 3 }
        else if 0.30 ... 0.40 ~= energy { return 4 }
        else if 0.40 ... 0.49 ~= energy { return 5 }
        else if 0.49 ... 0.51 ~= energy { return 0 }
        else if 0.51 ... 0.60 ~= energy { return 6 }
        else if 0.60 ... 0.70 ~= energy { return 7 }
        else if 0.70 ... 0.80 ~= energy { return 8 }
        else if 0.80 ... 0.90 ~= energy { return 9 }
        else if 0.90 ... 1 ~= energy { return 10 }
        return 0
    }
    var getPleasentness: Int {
        if 0 ... 0.10 ~= pleasentness { return 1 }
        else if 0.10 ... 0.20 ~= pleasentness { return 2 }
        else if 0.20 ... 0.30 ~= pleasentness { return 3 }
        else if 0.30 ... 0.40 ~= pleasentness { return 4 }
        else if 0.40 ... 0.49 ~= pleasentness { return 5 }
        else if 0.49 ... 0.51 ~= pleasentness { return 0 }
        else if 0.51 ... 0.60 ~= pleasentness { return 6 }
        else if 0.60 ... 0.70 ~= pleasentness { return 7 }
        else if 0.70 ... 0.80 ~= pleasentness { return 8 }
        else if 0.80 ... 0.90 ~= pleasentness { return 9 }
        else if 0.90 ... 1 ~= pleasentness { return 10 }
        return 0
    }

    let timer = Timer.publish(every: 1.25, on: .main, in: .common).autoconnect()
    @State private var animationOffset = false

    private var imageFullWidth = UIScreen.main.bounds.width * 2
    private let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        ZStack { // START: ZSTACK
            GeometryReader {reader in

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
extension CheckinFeelingsView {

    var contentContainer: some View {
        VStack { // START: VSTACK
            Group { // START: GROUP
                Spacer().frame(minHeight: 10, maxHeight: 20)
                Text(question)
                    .font(.system(size: 28.0, weight: .semibold))
                    .foregroundColor(Color.white)

                HStack {
                    Picker(selection: $selection, label: pickerLabel, content: {
                        ForEach(TimeRange.allCases, id: \.self) {
                            Text("\($0.rawValue)").tag($0)
                        }
                    })
                    .animation(.easeInOut)
                    .pickerStyle(MenuPickerStyle())
                }
                Spacer().frame(minHeight: 10, maxHeight: 20)
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
                Text(env.getMoodName(energy: getEnergy, pleasent: getPleasentness))
                    .font(.system(size: 27.0, weight: .semibold))
                    .italic()
                    .foregroundColor(Color.white)
                    .animation(.easeInOut)
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
                VStack(alignment: .leading) {
//                    Spacer()
//                        .frame(minHeight: 10, maxHeight: 50)
                    HStack {
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
                    HStack {
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
                VStack(alignment: .center) {
                    // Button
                    PrimaryButton(content: {
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

    var pickerLabel: some View {
        HStack {
            Text("This \(selection.rawValue)")
            Image(systemName: "chevron.down")
        }
        .frame(width: 150, height: 5)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 30)
                .stroke(Color.white, lineWidth: 2)
        ).background(RoundedRectangle(cornerRadius: 30).fill(Color.clear))
        .foregroundColor(.white)
    }
}

// MARK: - PREVIEW
struct CheckinFeelingsView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinFeelingsView()
            .background(EMTheme.shared.sea.ignoresSafeArea())
    }
}

