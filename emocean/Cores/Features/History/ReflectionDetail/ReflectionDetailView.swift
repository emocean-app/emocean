//
//  ReflectionDetailView.swift
//  emocean
//
//  Created by Puras Handharmahua on 01/08/21.
//

import SwiftUI

struct ReflectionDetailView: View {

    @Environment(\.presentationMode) private var presentationMode
    
    @StateObject private var viewModel = ReflectionDetailViewModel()
    @Binding var history: History?
    
    var body: some View {
        ZStack {
            // Background
            Color.white

            // Content
            if let history = history {
                ScrollView(.vertical) {
                    VStack {
                        // Top Section
                        HStack {
                            Text(
                                viewModel.getFormattedDate(
                                    format: "EEEE, MMM d yyyy",
                                    from: history.createdAt
                                )
                            )
                            .foregroundColor(Color.theme.primary)
                            Text("| \(Time(history.createdDate).getRawValue())")
                                .foregroundColor(Color.theme.primary)
                            Spacer()

                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color.theme.grayThird)
                            })
                        }
                        Spacer(minLength: 21)

                        // Header Section
                        Text(history.mood.name)
                            .font(.title2)
                            .italic()
                            .bold()
                            .foregroundColor(Color.theme.primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            CategoryLabel(labelCategory: history.category.name)
                            Spacer()
                        }
                        Spacer()

                        // Answers
                        VStack(spacing: 20) {
                            ForEach(0..<history.stories.count) { item in
                                VStack {
                                    Text(history.stories[item].question.question)
                                        .font(.subheadline)
                                        .foregroundColor(Color.theme.grayThird)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(history.stories[item].story)
                                        .foregroundColor(Color.theme.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding([.horizontal, .top], 25)
            } else {
                Text("No data available")
            }
        }
    }
}

struct ReflectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionDetailView(history: .constant(SeederStaticHistory().getAllHistory()[0]))
    }
}
