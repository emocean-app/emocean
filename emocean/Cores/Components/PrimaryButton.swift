//
//  PrimaryButton.swift
//  emocean
//
//  Created by Farrel Anshary on 27/07/21.
//

import SwiftUI

/// A solid button with primary color accent.
///
/// You can customize the maxWidth of this button if you need. Keep it empty to make it follows the text length.
///
/// ```
/// PrimaryButton(
///     content: {
///         HStack {
///             Image(systemName: "arrow.down.to.line.alt")
///             Text("Click Me!")
///         }
///     },
///     maxWidth: .infinity,
///     action: {
///         print("PrimaryButton Clicked")
///     }
/// )
/// ```
///
/// - Parameter content: The content for the button (should be inside HStack if you have multiple views)
/// - Parameter maxWidth: The width of the button
/// - Parameter action: a void closure, an action for ButtonOutlined
///
struct PrimaryButton<Content: View>: View {
    // MARK: PROPERTIES
    let content: Content
    let maxWidth: CGFloat?
    let action: () -> Void
    
    // MARK: INITIALIZER
    init(@ViewBuilder content: () -> Content, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.content = content()
        self.maxWidth = maxWidth
        self.action = action
    }
    
    // MARK: BODY
    var body: some View {
        Button(action: action, label: { // START: BUTTON
            content
                .foregroundColor(.white)
                .frame(maxWidth: maxWidth)
                .padding()
                .padding(.horizontal, 20)
                .background(Color.theme.primary)
                .clipShape(Capsule())
        }) // END: BUTTON
    }
}

// MARK: PREVIEW
struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(content: {
            HStack {
                Image(systemName: "arrow.down.to.line.alt")
                Text("Click Me!")
            }
        }, maxWidth: 150) {
            print("Primary Button Clicked")
        }
        .previewLayout(.sizeThatFits)
    }
}
