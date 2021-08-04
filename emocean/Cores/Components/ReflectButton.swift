//
//  ReflectButton.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI

struct ReflectButton: View {
    var body: some View {
        HStack(spacing: 0) { // START: HSTACK
            Image("Bawal")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 75, alignment: .trailing)
                .padding(.trailing, 5)
                .background(Color.theme.grayPrimary)

            VStack(alignment: .leading) { // START: VSTACK
                Text("Reflect Your Week!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.theme.primary)
                Text("It's time to look back and reflect at your week!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.primary)
                .padding(.trailing, 3)
                // END: HSTACK
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 10)
            .background(Color.white)
            // END: VSTACK

            Image(systemName: "chevron.right")
                .frame(maxWidth: 25, maxHeight: .infinity)
                .foregroundColor(Color.theme.graySecondary)
                .background(Color.theme.grayPrimary)
        }
        .padding(0)
        .frame(height: 100, alignment: .center)
        .cornerRadius(15)
    }
}

struct ReflectButton_Previews: PreviewProvider {
    static var previews: some View {
        ReflectButton()
            .previewLayout(.sizeThatFits)
    }
}
