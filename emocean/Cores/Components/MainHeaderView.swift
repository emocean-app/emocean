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
    
    @EnvironmentObject var settingsEnv: SettingsViewModel

    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                LottieView(filename: time.getSkyAnimation(), contentMode: .scaleAspectFill)
                    .offset(y: -getOffset(reader, multiplier: 1.5))
                    .frame(width: reader.size.width, height: reader.size.height)

                Image("\(time.getRawValue())Sea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 2) + 15)
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 2) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: !settingsEnv.reduceMotion ? 20 : 0, orientation: .vertical))
                
                Image("Boat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 4) + 40)
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 4) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: !settingsEnv.reduceMotion ? 30 : 0, orientation: .vertical))

                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 75)

                        Text("Ahoy!")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(time.timeRange == .night ? .white : Color.theme.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)

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

                    VStack {
                        Spacer()
                            .frame(height: 75)
                        Button(action: {
                            self.shouldShowSettingsModal = true
                        }, label: {
                            Image(systemName: "gearshape")
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .center)
                                .foregroundColor(time.timeRange == .night ? .white : Color.theme.primary)
                        })
                    }
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
            .environmentObject(SettingsViewModel())
    }
}
