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
    let backgroundImage: String
    let headerForegroundColor: Color

    var body: some View {
        GeometryReader { reader in
            ZStack(alignment: .top) {
                Image("\(backgroundImage)Sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 1.5))
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 2) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10, orientation: .vertical))

                Image("\(backgroundImage)Sea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 3))
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 3) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 20, orientation: .vertical))
                
                Image("Boat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y: -getOffset(reader, multiplier: 8) + 25)
                    .frame(width: reader.size.width, height: getOffset(reader, multiplier: 8) + 480)
                    .modifier(ParallaxMotionModifier(manager: manager, magnitude: 30, orientation: .vertical))

                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 75)
                    Text("Ahoy!")
                        .foregroundColor(headerForegroundColor)
                        .font(.largeTitle)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Do you wanna check in?")
                        .foregroundColor(headerForegroundColor)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        PrimaryButton {
                            HStack {
                                Image(systemName: "lifepreserver")
                                Text("Let's Dive In!")
                                    .bold()
                            }
                        } action: {
                            self.shouldPopUpFullScreen = true
                        }

                    }
                    Spacer()
                }
                .padding(.horizontal)
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
        MainHeaderView(shouldPopUpFullScreen: .constant(false), backgroundImage: "Night", headerForegroundColor: .white)
    }
}
