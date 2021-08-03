//
//  HistoryView.swift
//  emocean
//
//  Created by Puras Handharmahua on 03/08/21.
//

import SwiftUI

struct HistoryView: View {
    
    @State private var selectedDate: DateComponents = {
        return Calendar.current.dateComponents([.day,.month,.year], from: Date())
    }()
    
    private var selectedDateString: String {
        let date = Calendar.current.date(from: selectedDate)
        
        guard let date = date else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d yyyy"
        
        return formatter.string(from: date)
    }
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor(named: "Primary")
    }
    
    var body: some View {
        ZStack { // START: ZSTACK
            ScrollView { // START: SCROLL VIEW
                VStack(spacing: 25) { // START: VSTACK
                    
                    VStack(spacing: 0) { // START: VSTACK
                        EMCalendar(date: $selectedDate)
                            .frame(minHeight: 300)
                            .padding(.horizontal, 8)
                            .padding(.bottom, -10)
                        
                        Text(selectedDateString)
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
                            ForEach(0..<2) { _ in // START: FOREACH
                                ReflectionCell(
                                    time: "Morning",
                                    mood: "Disgusted",
                                    image: "Bawal",
                                    bgColor: .blue,
                                    categories: ["Work", "Relationship"]
                                )
                            } // END: FOREACH
                        } // END: VSTACK
                        .padding(.horizontal)
                        .padding(.horizontal)
                        
                        Text("Weekly Refelections")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .padding(.horizontal)
                        
                        VStack(spacing: 20) { // START: VSTACK
                            ForEach(0..<2) { _ in // START: FOREACH
                                ReflectionCell(
                                    time: "Morning",
                                    mood: "Disgusted",
                                    image: "Bawal",
                                    bgColor: .blue,
                                    categories: ["Work", "Relationship"]
                                )
                            } // END: FOREACH
                        } // START: VSTACK
                        .padding(.horizontal)
                        .padding(.horizontal)
                    } // END: VSTACK
                } // END: VSTACK
            } // END: SCROLL VIEW
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
        } // END: ZSTACK
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView()
                .navigationBarTitle(
                    Text("History")
                        .foregroundColor(.white)
                )
        }
    }
}
