//
//  CategoryLabel.swift
//  emocean
//
//  Created by Christian Adiputra on 28/07/21.
//

/// A label for Category
///
/// You can customize the category of this label if you need
///
/// ```
/// PrimaryButton(
///     labelCategory: "Relationship",
/// )
/// ```
///
/// - Parameter labelCategory: The category for the label


import SwiftUI

struct CategoryLabel: View {
    // MARK: - PROPERTIES
    var labelCategory: String
    private let mainColor = Color(red: 16/255, green: 28/255, blue: 56/255)
    private let bgColor = Color(red: 232/255, green: 234/255, blue: 237/255)
    var body: some View {
        Text(labelCategory)
            .font(.caption2)
            .foregroundColor(mainColor)
            .padding(2)
            .padding(.horizontal,5)
            .background(bgColor.clipShape(Capsule()))
    }
}

struct CategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLabel(labelCategory: "Relationship")
            .previewLayout(.sizeThatFits)
            .background(Color.black)
    }
}
