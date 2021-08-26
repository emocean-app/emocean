//
//  ChartDescriptionView.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct ChartDescriptionView: View {
    let patternTime = [
        "Most of the time you feel",
        "Often you feel",
        "Sometimes you feel",
        "You rarely feel"
    ]
    
    let pattern = [
        "red": "unpleasant and high on energy",
        "blue": "unpleasant and low on energy",
        "green": "pleasant and low on energy",
        "yellow": "pleasant and high on energy"
    ]
    
    let quadrantColor = [
        "red": Color.theme.redQuadrant,
        "blue": Color.theme.blueQuadrant,
        "green": Color.theme.greenQuadrant,
        "yellow": Color.theme.yellowQuadrant
    ]
    
    let quadrants: [Quadrant]
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 20)

            ForEach(0..<quadrants.count, id: \.self) { idx in
                HStack {
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(quadrantColor[quadrants[idx].quadrant])
                    Text("\(patternTime[idx]) \(pattern[quadrants[idx].quadrant]!)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(Color.theme.primary)
                }

                Spacer()
                    .frame(height: 20)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

struct ChartDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDescriptionView(quadrants: [
            Quadrant(quadrant: "yellow", count: 1)
        ])
            .previewLayout(.sizeThatFits)
            .background(Color.theme.seaBottomGradient)
    }
}
