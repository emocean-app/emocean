//
//  ChartDescriptionView.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct ChartDescriptionView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.theme.redQuadrant)
                Text("Most of the time you don't feel pleasant and high on energy")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.primary)
            }

            Spacer()
                .frame(height: 20)

            HStack(alignment: .center) {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.theme.yellowQuadrant)
                Text("Often you feel pleasant and high on energy")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.primary)
            }

            Spacer()
                .frame(height: 20)

            HStack(alignment: .center) {
                Circle()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.theme.blueQuadrant)
                Text("You rarely feel unpleasant with low energy level")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.primary)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct ChartDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDescriptionView()
            .previewLayout(.sizeThatFits)
            .background(Color.theme.seaBottomGradient)
    }
}
