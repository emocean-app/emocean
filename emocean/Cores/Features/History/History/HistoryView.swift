//
//  HistoryView.swift
//  emocean
//
//  Created by Puras Handharmahua on 03/08/21.
//

import SwiftUI

struct HistoryView: View {

    @StateObject var viewModel = HistoryViewModel()
    @State var shouldShowModal = false
    @State var history: History?
    let quadrantColor = [
        "red": Color.theme.redQuadrant,
        "blue": Color.theme.blueQuadrant,
        "green": Color.theme.greenQuadrant,
        "yellow": Color.theme.yellowQuadrant
    ]

    var body: some View {
        VStack { // START: ZSTACK
            ScrollView { // START: SCROLL VIEW
                VStack(spacing: 25) { // START: VSTACK
                    VStack(spacing: 0) { // START: VSTACK
                        HStack {
                            Text("History")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color.theme.grayPrimary)
                                .padding(.horizontal, 20)
                                .padding(.bottom)
                            Spacer()
                        }
                        EMCalendar(date: $viewModel.selectedDate)
                            .frame(minHeight: 300)
                            .padding(.horizontal, 8)
                            .padding(.bottom, -10)
                        
                        Text(viewModel.selectedDateString)
                            .foregroundColor(.white)
                            .font(.subheadline)
                            .padding()
                            .padding(.horizontal)
                            .padding(.leading, 30)
                            .background(Color.theme.primary)
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(x: -35, y: 20)
                    }// END: VSTACK
                    .background(
                        Color.theme.primary
                    )

                    VStack { // START: VSTACK
                        Text("Daily Refelections")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .padding(.horizontal)

                        VStack(spacing: 20) {// START: VSTACK
                            if !viewModel.histories.isEmpty {
                                ForEach(0..<viewModel.histories.count, id: \.self) { idx in
                                    Button(action: {
                                        self.history = viewModel.histories[idx]
                                        self.history?.stories.reverse()
                                        self.shouldShowModal = true
                                    }, label: {
                                        ReflectionCell(
                                            time: Time(viewModel.histories[idx].createdDate).getRawValue(),
                                            mood: viewModel.histories[idx].mood.name,
                                            image: viewModel.histories[idx].mood.imageUrl,
                                            bgColor: quadrantColor[viewModel.histories[idx].mood.quadrant]!,
                                            categories: [viewModel.histories[idx].category.name])
                                    })
                                    .padding(.bottom, idx == viewModel.histories.count - 1 ? 60 : 0)
                                }
                            } else {
                                Text("No data for this date")
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                            }
                        } // END: VSTACK
                        .padding(.horizontal)
                        .padding(.horizontal)
                    } // END: VSTACK
                } // END: VSTACK
            } // END: SCROLL VIEW
        } // END: ZSTACK
        .sheet(isPresented: $shouldShowModal, content: {
            ReflectionDetailView(history: $history)
        })
        .background(
            GeometryReader { reader in
                VStack(spacing: 0) {
                    Color.theme.primary
                        .frame(height: reader.safeAreaInsets.top)
                    EMTheme.shared.sea
                }
                .ignoresSafeArea()
            }
        )
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
