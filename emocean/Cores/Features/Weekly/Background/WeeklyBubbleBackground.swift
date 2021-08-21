//
//  WeeklyBubbleBackground.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import SwiftUI

struct WeeklyBubbleBackground: View {
    var body: some View {
        GeometryReader { geometry in // START: GEOMETRY
            VStack { // START: VSTACK
                // Spacing from the top side
                Spacer()
                    .frame(height: geometry.size.height * 0.1)
                // Container for bubble image
                HStack { // START: HSTACK
                    Spacer()
                    // Bubble image
                    Image("Bubble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 4)
                    .rotationEffect(.degrees(-180))
                    .opacity(0.4)
                } // END: HSTACK
                .frame(maxWidth: .infinity)
                Spacer()
                // Container for bubble image
                HStack { // START: HSTACK
                    Image("Bubble")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 4)
                    .opacity(0.4)
                    Spacer()
                } // END: HSTACK
                .padding(.leading, 10)
                Spacer()
                    .frame(height: geometry.size.height * 0.1)
            } // END: VSTACK
        } // END: GEOMETRY
    }
}

struct WeeklyBubbleBackground_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyBubbleBackground()
            .background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
