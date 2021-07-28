//
//  GoalCell.swift
//  emocean
//
//  Created by Christian Adiputra on 28/07/21.
//
/// Cell for Goal page.
///
/// You have to define give padding.
///
/// ```
/// GoalCell(
///     category: "Relationship",
///     goal: "I Want to Focus on myself more so one day I’llachive the things I want...",
///     date: "January 30th 2021",
/// )
/// ```
///
/// - Parameter category: The segment category string
/// - Parameter goal: The goal string
/// - Parameter date: The date String
///
import SwiftUI

struct GoalCell: View {
    @State var category: String
    @State var goal: String
    @State var date: String
    private let mainColor = Color(red: 16/255, green: 28/255, blue: 56/255)
    private let bgColor = Color(red: 237/255, green: 238/255, blue: 241/255)
    var body: some View {
        Button(action: {}, label: {
         
                HStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        HStack {
                            CategoryLabel(labelCategory: category)
                            Text(date)
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        Spacer()
                        Text("I Want to Focus on myself more so one day I’llachive the things I want...")
                            .frame(height: 50)
                            .foregroundColor(mainColor)
                            .lineLimit(2)
                            .padding(.bottom,5)
                    }
                    .padding()
                    Image(systemName: "chevron.right")
                        .frame(maxWidth: 25, maxHeight: .infinity)
                        .foregroundColor(Color(.displayP3, red: 26/255, green: 41/255, blue: 76/255, opacity: 0.15))
                        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                }
                .frame(height: 90, alignment: .center)
                .background(bgColor)
                .cornerRadius(15)
        })
    }
}

struct GoalCell_Previews: PreviewProvider {
    static var previews: some View {
        GoalCell(category:"Relationship",goal:"I want to Focus on myself more so one day I’llachive the things I want...",date:"January 30th 2021")
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black)
    }
}
