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
    private let primary = Color.theme.primary
    var body: some View {
            Text(labelCategory)
                .font(.caption2)
                .foregroundColor(primary)
                .padding(2)
                .padding(.horizontal,5)
                .background(primary.clipShape(Capsule()).opacity(0.15))
    }
}

struct CategoryLabel_Previews: PreviewProvider {
    static var previews: some View {
        CategoryLabel(labelCategory: "Relationship")
            .previewLayout(.sizeThatFits)
    }
}
