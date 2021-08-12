//
//  EmotionChart.swift
//  emocean
//
//  Created by Farrel Anshary on 30/07/21.
//

import SwiftUI

/// A chart for defining the emotion pattern
///
/// Just simply call the struct and fill the parameter with the values.
///
/// Usage example:
/// ```
/// EmotionChart(
///     red: 4,
///     blue: 3,
///     green: 6,
///     yellow: 2
/// )
/// ```
///
/// - Parameter red: Value of red
/// - Parameter blue: Value of blue
/// - Parameter green: Value of green
/// - Parameter yellow: Value of yellow
///

struct EmotionChart: View {
    var emotionArray: [ChartData]

    // MARK: INITIALIZER
    init(red: CGFloat, blue: CGFloat, green: CGFloat, yellow: CGFloat) {
        let total: CGFloat = red + blue + green + yellow

        self.emotionArray = [
            ChartData(
                emotion: .blue,
                value: blue/total,
                color: Color.theme.blueQuadrant,
                image: ["ArwanaDua", "BuntelDua"]
            ),
            ChartData(
                emotion: .green,
                value: green/total,
                color: Color.theme.greenQuadrant,
                image: ["GuritaDua", "CupangDua"]
            ),
            ChartData(
                emotion: .yellow,
                value: yellow/total,
                color: Color.theme.yellowQuadrant,
                image: ["KudaDua", "NemoDua"]
            ),
            ChartData(
                emotion: .red,
                value: red/total,
                color: Color.theme.redQuadrant,
                image: ["KepitingDua", "GuritaDua"]
            )
        ]

        sortData()
    }

    // MARK: Sort Function
    mutating func sortData() {
        self.emotionArray.sort {
            $0.value > $1.value
        }

        var start: CGFloat = 0.0
        for index in 0..<self.emotionArray.count {
            self.emotionArray[index].startPoint = start
            start += self.emotionArray[index].value
        }
    }

    var body: some View {
        ZStack { // START: ZSTACK
            ForEach(emotionArray, id:\.self) { emotion in
                Circle()
                    .trim(from: emotion.startPoint!, to: emotion.startPoint! + emotion.value)
                    .stroke(style: StrokeStyle(lineWidth: 40, lineCap: .round))
                    .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(emotion.color)
            } // END: FOREACH

            Image(emotionArray[0].image.randomElement()!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
        }
        .padding(30)
        // END: ZSTACK
    }
}

// MARK: - Classes
enum EmotionColor {
    case blue
    case red
    case green
    case yellow
}

struct ChartData: Hashable {
    let emotion: EmotionColor
    let value: CGFloat
    let color: Color
    var startPoint: CGFloat?
    var image: [String]
}

// MARK: - Preview
struct EmotionChart_Previews: PreviewProvider {
    static var previews: some View {
        EmotionChart(red: 15, blue: 10, green: 21, yellow: 40)
            .previewLayout(.sizeThatFits)
    }
}
