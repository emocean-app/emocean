//
//  WentFishingView.swift
//  emocean
//
//  Created by Christian Adiputra on 05/08/21.
//

import SwiftUI

struct WentFishingView: View {
    var body: some View {
        ZStack{
            EMTheme.shared.sea.ignoresSafeArea()
            VStack (alignment: .center, spacing: 0) {
                Spacer()
                LottieView(filename: "GambarGoneFishing", contentMode: .scaleToFill)
                    .frame(width: 250, height: 250, alignment: .center)
                Text("Gone Fishing!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.bottom, 3)
                Text("This page will be available soon")
                    .foregroundColor(.white)
                Spacer()
                Spacer()
            }
        }
    }
}

struct WentFishingView_Previews: PreviewProvider {
    static var previews: some View {
        WentFishingView()
    }
}
