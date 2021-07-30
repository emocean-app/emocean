//
//  ReflectionCell.swift
//  emocean
//
//  Created by Farrel Anshary on 28/07/21.
//

import SwiftUI
import WrappingHStack
/// Cell for Reflection page.
///
/// This cell has width of .infinity.
/// You have to define the width or give padding.
///
/// ```
/// ReflectionCell(
///     time: "Morning",
///     mood: "Disgusted",
///     image: "Bawal",
///     bgColor: .blue,
///     categories: ["Work", "Relationship", "Games", "Family"]
/// )
/// ```
///
/// - Parameter time: Dawn, Morning, Noon, Afternoon, or Night
/// - Parameter mood: The mood string
/// - Parameter image: The fish image String
/// - Parameter bgColor: Color for image background
/// - Parameter categories: Array of categories
///
struct ReflectionCell: View {
    // MARK: PROPERTIES
    let time: String
    let mood: String
    let image: String
    let bgColor: Color
    let categories: [String]

    // MARK: BODY
    var body: some View {
        HStack(spacing: 0) { // START: HSTACK
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 75, alignment: .trailing)
                .padding(.trailing, 5)
                .background(bgColor)

            VStack(alignment: .leading) { // START: VSTACK
                Text(time)
                    .font(.footnote)
                    .foregroundColor(Color.theme.grayThird)
                Text(mood)
                    .font(.system(size: 17, weight: .heavy, design: .default))
                    .foregroundColor(Color.theme.primary)
                Spacer()
                WrappingHStack(categories, id: \.self, spacing: .constant(3)) { category in // START: HSTACK
                    CategoryLabel(labelCategory: category)
                        .padding(.vertical, 3)
                }
                .padding(.trailing, 3)
                // END: HSTACK
            }
            .padding(.vertical, 5)
            .padding(.leading, 10)
            .background(Color.white)
            // END: VSTACK

            Image(systemName: "chevron.right")
                .frame(maxWidth: 25, maxHeight: .infinity)
                .foregroundColor(Color.theme.graySecondary)
                .background(Color.theme.grayPrimary)
        }
        .frame(height: 100, alignment: .center)
        .cornerRadius(15)
        // END: HSTACK
    }
}

// MARK: PREVIEW
struct ReflectionCell_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionCell(time: "Morning", mood: "Angry", image: "Jellyfish", bgColor: Color.theme.redQuadrant, categories: ["News", "Relationship", "Coronavirus"])
            .previewLayout(.sizeThatFits)
    }
}
