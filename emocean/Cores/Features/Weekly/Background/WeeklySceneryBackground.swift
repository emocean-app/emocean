//
//  WeeklySceneryBackground.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import SwiftUI

struct WeeklySceneryBackground: View {
    let time = Time()
    
    var body: some View {
        ZStack {
            GeometryReader {reader in
                LottieView(filename: "\(time.getRawValue())Ending",
                           contentMode:
                            .scaleAspectFit).ignoresSafeArea(edges: .top)
                VStack() {
                    Spacer()
                    Image("RSunset")
                        .resizable()
                        .frame(
                            width: reader.size.width * 1.25
                        )
                }
                .frame(
                    width: reader.size.width,
                    alignment: .leading
                )
            }
        }.ignoresSafeArea()
        .preferredColorScheme(time.timeRange == .night ? .dark : .light)
    }
}

struct WeeklySceneryBackground_Previews: PreviewProvider {
    static var previews: some View {
        WeeklySceneryBackground()
    }
}
