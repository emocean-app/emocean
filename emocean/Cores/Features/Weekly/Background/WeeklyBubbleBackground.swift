//
//  WeeklyBubbleBackground.swift
//  emocean
//
//  Created by Puras Handharmahua on 20/08/21.
//

import SwiftUI

struct WeeklyBubbleBackground: View {
    // MARK: PROPERTIES
    var isBubble: Bool = true
    private let time = Time()
    // MARK: BODY
    var body: some View {
        ZStack {
            // - BACKGROUND
            VStack(spacing: 0) { // START: VSTACK
                // Only show this when isBubble is false
                if !isBubble {
                    // - SAILOR IMAGE
                    sailorImage
                }
                // - SEA BACKGROUND
                EMTheme.shared.sea
                    .animation(.easeInOut)
            } // END: VSTACK
            .ignoresSafeArea()
            // Only show coral when isBubble is true
            if isBubble {
                // - BUBBLE IMAGE
                bubble
            }
            // Only show this when isBubble is false
            if !isBubble {
                Group { // START: GROUP
                    // - BACK CORAL
                    backCoral
                    // - FRONT CORAL
                    frontCoral
                } // END: GROUP
                .transition(.move(edge: .bottom))
                .animation(.easeInOut)
            }
        }
    }
}

// MARK: - COMPONENTS
extension WeeklyBubbleBackground {
    // SAILOR IMAGE
    var sailorImage: some View {
        Image("Up\(time.getRawValue())")
            .resizable()
            .scaledToFit()
            .transition(
                .asymmetric(
                    insertion: .move(edge: .top),
                    removal: .move(edge: .top)
                )
            )
            .animation(.easeInOut)
    }
    // BUBBLE
    var bubble: some View {
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
                        .transition(.move(edge: .trailing))
                        .animation(.easeInOut)
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
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut)
                    Spacer()
                } // END: HSTACK
                .padding(.leading, 10)
                Spacer()
                    .frame(height: geometry.size.height * 0.1)
            } // END: VSTACK
        } // END: GEOMETRY
    }
    // BACK CORAL
    var backCoral: some View {
        VStack(alignment: .trailing) { // START: VSTACK
            Spacer()
            Image("BackCoral")
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.2,
                    alignment: .leading
                )
        } // END: VSTACK
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: .center
        )
        .ignoresSafeArea()
    }
    // FRONT CORAL
    var frontCoral: some View {
        VStack(alignment: .trailing) { // START: VSTACK
            Spacer()
            Image("FrontCoral")
                .resizable()
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.2,
                    alignment: .leading
                )
        } // END: VSTACK
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: .center
        )
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEW
struct WeeklyBubbleBackground_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyBubbleBackground()
    }
}
