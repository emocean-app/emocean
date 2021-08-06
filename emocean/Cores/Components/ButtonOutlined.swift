//
//  ButtonOutlined.swift
//  emocean
//
//  Created by Puras Handharmahua on 27/07/21.
//
import SwiftUI

/// A Button with outline around it.
///
/// This button has two theme, light and dark.
/// light theme will give the button white outline and white text color, while dark theme is black
///
/// ```
/// ButtonOutlined(
///     text: "Title",
///     isSelected: $selected,
///     isLight: true,
///     action: {
///         print("ButtonOutlined Clicked")
///     }
/// )
/// ```
///
/// - Parameter text: The title for button
/// - Parameter isSelected: a binding Boolean
/// - Parameter isLight: Boolean, wheter the button outlined is light or dark theme
/// - Parameter action: a void closure, an action for ButtonOutlined
///
struct ButtonOutlined: View {
    
    // MARK: PROPERTIES
    var text: String
    var isSelected: Bool
    var isLight: Bool = true
    var action: (() -> Void?)? = nil
    
    private let whiteOpacity = Color.white.opacity(0.5)
    private let whiteColor = Color.white
    private let blackColor = Color.black
    private let clearColor = Color.clear
    
    // MARK: BODY
    var body: some View {
        Button(action: { // START: BUTTON
            action?()
        }, label: {
            Text(text)
                .foregroundColor(isLight ? .white : .black)
                .frame(maxWidth: .infinity)
                .padding()
                .padding(.horizontal,5)
                .background( // START: BACKGROUND
                    ZStack { // START: ZTACK
                        backgroundLayer
                            .clipShape(Capsule())
                        Capsule()
                            .stroke(
                                strokeLayer,
                                style: StrokeStyle(
                                    lineWidth: 2
                                )
                            )
                    } // END: ZTACK
                ) // END: BACKGROUND
        }) // END: BUTTON
    }
}

// MARK: - COMPONENTS
extension ButtonOutlined {
    var backgroundLayer: Color {
        if isSelected {
            return
                whiteOpacity
        } else {
            return clearColor
        }
    }
    
    var strokeLayer: Color {
        if isLight && isSelected {
            return clearColor
        } else if isLight && !isSelected {
            return whiteColor
        } else {
            return blackColor
        }
    }
}

// MARK: PREVIEW
struct ButtonOutlined_Previews: PreviewProvider {
    static var previews: some View {
        ButtonOutlined(
            text: "Relationship",
            isSelected: false,
            action: {
                print("Outlined Button Clicked")
            }
        )
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.purple)
    }
}
