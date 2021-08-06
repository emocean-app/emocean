//
//  MainHeaderView.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct MainHeaderView: View {
    @ObservedObject var manager = MotionManager()
    @Binding var shouldPopUpFullScreen: Bool
    @Binding var shouldShowSettingsModal: Bool
    let time = Time()

    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                LottieView(filename: time.getSkyAnimation(), contentMode: .scaleAspectFill)
                    .offset(y: -getOffset(reader, multiplier: 1.5))
                    .frame(width: reader.size.width, height: reader.size.height)

                Image("\(time.getRawValue())Sea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 3) + 15)
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 3) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 20, orientation: .vertical))
                
                Image("Boat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 10) + 40)
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 8) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 30, orientation: .vertical))

                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 75)

                    HStack {
                        Text("Ahoy!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(time.timeRange == .night ? .white : Color.theme.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button(action: {
                            self.shouldShowSettingsModal = true
                        }, label: {
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(time.timeRange == .night ? .white : Color.theme.primary)
                        })
                    }

                    Text("Do you wanna check in?")
                        .font(.title3)
                        .foregroundColor(time.timeRange == .night ? .white : Color.theme.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if time.timeRange == .night {
                        GrayButton {
                            HStack {
                                Image(systemName: "lifepreserver")
                                Text("Let's Dive In!")
                                    .bold()
                            }
                            .padding(.horizontal, 5)
                        } action: {
                            self.shouldPopUpFullScreen = true
                        }
                    } else {
                        PrimaryButton {
                            HStack {
                                Image(systemName: "lifepreserver")
                                Text("Let's Dive In!")
                                    .bold()
                            }
                            .padding(.horizontal, 5)
                        } action: {
                            self.shouldPopUpFullScreen = true
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 30)
            }
        }
        .frame(height: 480)
    }

    func getOffset(_ reader: GeometryProxy, multiplier: CGFloat) -> CGFloat {
        let offset = reader.frame(in: .global).minY

        if offset <= 0 {
            return offset / multiplier
        }

        return offset
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(shouldPopUpFullScreen: .constant(false), shouldShowSettingsModal: .constant(false))
    }
}
