//
//  ProgressBubble.swift
//  emocean
//
//  Created by Farrel Anshary on 28/07/21.
//

import SwiftUI

/// A bubble to represent a day progress
///
/// This bubble has two states, not done and done.
/// Not done will give the bubble white outline and white text color, while done will give white background color.
///
/// This bubble also has two states, today and not today. If the day is today so there will be a triangle above it.
///
/// ```
/// ProgressBubble(
///     dayOfWeek: 2,
///     isDone: true,
///     isToday: true
/// )
/// ```
///
/// - Parameter day: The day of week in int
/// - Parameter isDone: Whether the day is done or not
/// - Parameter isToday: Whether the day is today
///
struct ProgressBubble: View {
    let day: Int
    let isDone: Bool
    let isSelected: Bool

    let strokeColor: Color
    let backgroundColor: Color

    // MARK: INITIALIZER
    init(dayOfWeek: Int, isDone: Bool, isToday: Bool) {
        self.day = dayOfWeek
        self.isDone = isDone
        self.isSelected = isToday

        if isDone {
            self.strokeColor = Color.theme.primary
            self.backgroundColor = .white
        } else {
            self.strokeColor = .white
            self.backgroundColor = .clear
        }
    }

    // MARK: BODY
    var body: some View {
        VStack { // START: VSTACK
            if isSelected {
                Image("SelectedDay")
            }
            ZStack { // START: ZSTACK
                if isDone {
                    Circle()
                        .foregroundColor(backgroundColor)
                        .frame(width: 40, height: 40)
                } else {
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 2)
                        .frame(width: 40, height: 40)
                }
                Circle()
                    .trim(from: 0.0, to: 0.25)
                    .stroke(strokeColor, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 25, height: 25)
                Text(getDayOfWeek(dayInt: day))
                    .foregroundColor(strokeColor)
                    .bold()
            } // END: ZSTACK
        } // END: VSTACK
    }
    
    // MARK: - Get day string from day int
    func getDayOfWeek(dayInt day: Int) -> String {
        switch day {
        case 0:
            return "S"
        case 1:
            return "M"
        case 2:
            return "T"
        case 3:
            return "W"
        case 4:
            return "T"
        case 5:
            return "F"
        case 6:
            return "S"
        default:
            return "U"
        }
    }
}

// MARK: - COMPONENTS
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

// MARK: PREVIEW
struct ProgressBubble_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBubble(dayOfWeek: 2, isDone: true, isToday: true)
            .padding()
            .background(Color.purple)
            .previewLayout(.sizeThatFits)
    }
}
