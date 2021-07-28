//
//  ReflectionCell.swift
//  emocean
//
//  Created by Farrel Anshary on 28/07/21.
//

import SwiftUI
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
                .aspectRatio(contentMode: .fit)
                .padding(5)
                .frame(maxWidth: 90, maxHeight: .infinity)
                .background(bgColor)

            VStack(alignment: .leading) { // START: VSTACK
                Text(time)
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text(mood)
                    .font(.system(size: 17, weight: .heavy, design: .default))
                Spacer()
                ScrollView(.horizontal, showsIndicators: false, content: { // START: SCROLLVIEW
                    HStack { // START: HSTACK
                        ForEach(categories, id: \.self) { category in
                            if category == categories.last {
                                CategoryLabel(labelCategory: category)
                                    .padding(.trailing, 10)
                            } else {
                                CategoryLabel(labelCategory: category)
                            }
                        }
                    } // END: HSTACK
                }) // END: SCROLLVIEW
                .padding(.trailing, 0)
            } // END: VSTACK
            .padding(.vertical, 5)
            .padding(.leading, 10)
            .background(Color.white)

            Image(systemName: "chevron.right")
                .frame(maxWidth: 25, maxHeight: .infinity)
                .foregroundColor(Color(.displayP3, red: 26/255, green: 41/255, blue: 76/255, opacity: 0.15))
                .background(Color(red: 230/255, green: 230/255, blue: 230/255))
        } // END: HSTACK
        .frame(height: 90, alignment: .center)
        .cornerRadius(15)
    }
}

// MARK: PREVIEW
struct ReflectionCell_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionCell(time: "Morning", mood: "Disgusted", image: "Bawal", bgColor: .blue, categories: ["Work", "Relationship", "Games", "Family"])
            .previewLayout(.sizeThatFits)
    }
}
