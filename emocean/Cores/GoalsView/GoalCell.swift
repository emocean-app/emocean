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
    @State var isCompleted: Bool
    var body: some View {
        Button(action: {}, label: {
         
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            CategoryLabel(labelCategory: category)
                            Text(date)
                                .foregroundColor(.gray)
                                .font(.footnote)
                        }
                        Text(goal)
                            .frame(minHeight: 50)
                            .foregroundColor(Color.theme.primary)
                            .lineLimit(2)
                            .padding(.top,0)
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "chevron.right")
                        .frame(maxWidth: 25, maxHeight: .infinity)
                        .foregroundColor(Color(.displayP3, red: 26/255, green: 41/255, blue: 76/255, opacity: 0.15))
                        .background(Color(red: 230/255, green: 230/255, blue: 230/255))
                }
        })
        .frame(height: 90, alignment: .center)
        .background(Color.theme.grayPrimary)
        .cornerRadius(25)
    }
}

struct GoalCell_Previews: PreviewProvider {
    static var previews: some View {
        GoalCell(category: "Relationship",goal: "Hello Mr Crab adaasda daskdadmak adksadka adsnkd",date: "January 30th 2021", isCompleted: true)
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.black)
    }
}
