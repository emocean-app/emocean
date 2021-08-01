//
//  EMCalendar.swift
//  emocean
//
//  Created by Puras Handharmahua on 01/08/21.
//

import SwiftUI

/// A Calendar
///
/// This calendar take one parameter: A Binding of DateComponent
///
/// ```
/// @State private var date: DateComponents = {
///     return Calendar.current.dateComponents([.day,.year,.month], from: Date())
/// }()
///
/// var body: some View {
///     EMCalendar(date: $date)
/// }
/// ```
struct EMCalendar: View {
    
    // MARK: PROPERTIES
    @StateObject private var vm = EMCalendarViewModel()
    @Binding var date: DateComponents
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    // MARK: BODY
    var body: some View {
        ScrollView { // START: SCROLLVIEW
            ZStack { // START: ZSTACK
                // Background
                Color.white
                
                // Content
                VStack { // START: VSTACK
                    // Top
                    topSection
                    
                    // Days
                    daysSection
                    
                    // Cell Date
                    cellDatesSection
                    
                    Spacer()
                } // START: VSTACK
                .padding(20)
            } // END: ZSTACK
            .cornerRadius(20)
            .padding()
            .onReceive(vm.$dateSelected, perform: { val in
                if(val.day != 0) {
                    date = val
                }
            })
        } // START: SCROLLVIEW
        .disabled(true)
    }
}

// MARK: - COMPONENTS

extension EMCalendar {
    var topSection: some View {
        HStack { // START: HSTACK
            Text("\(vm.getMonthName()), \(String(vm.year))")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "chevron.left")
                .onTapGesture {
                    vm.decrementMonth()
                }
            Image(systemName: "chevron.right")
                .onTapGesture {
                    vm.incrementMonth()
                }
        } // END: HSTACK
        .foregroundColor(Color.theme.primary)
    }
    
    var daysSection: some View {
        LazyVGrid(columns: columns, content: { // START: LVGRID
            ForEach(vm.days, id: \.self) { item in // START: FOREACH
                Text(item)
                    .foregroundColor(.gray)
                    .font(.caption)
            } // END: FOREACH
        }) // END: LVGRID
        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .leading)))
        .animation(.easeInOut(duration: 0.5))
    }
    
    var cellDatesSection: some View {
        LazyVGrid(columns: columns, content: { // START: LVGRID
            ForEach(1..<43) { item in // START: FOREACH
                if vm.isCellAvailable(cellNumber: item) { // START: IF
                    ZStack { // START: ZSTACK
                        // Background
                        if vm.isSelectedDate(cellNumber: item) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.5))
                        } else if vm.isTodayDate(cellNumber: item) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                        }
                        
                        
                        VStack(spacing: 3) { // START: VSTACK
                            // Date Number
                            Text(
                                vm.cellToDateString(cellNumber: item)
                            )
                            .foregroundColor(Color.theme.primary)
                            .font(.title3)
                            
                            
                            // Circle Identifier
                            HStack(spacing: 4) { // START: HSTACK
                                Circle()
                                    .fill(
                                        Color.theme.morningTopGradient
                                    )
                                    .frame(width: 5, height: 5)
                                Circle()
                                    .fill(
                                        Color.theme.greenQuadrant
                                    )
                                    .frame(width: 5, height: 5)
                                Circle()
                                    .fill(
                                        Color.theme.calendarBullet3
                                    )
                                    .frame(width: 5, height: 5)
                            } // END: HSTACK
                        } // END: VSTACK
                        .padding(7)
                    } // END: ZSTACK
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        vm.setSelectedDate(cellNumber: item)
                    }
                } else { // END: IF-START: ELSE
                    VStack {}
                } // END: ELSE
            } // END: FOREACH
        }) // END: LVGRID
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
        .animation(.easeInOut(duration: 0.5))

    }
}

// MARK: - PREVIEW
struct EMCalendar_Previews: PreviewProvider {
    
    @State private var date: DateComponents = {
        return Calendar.current.dateComponents([.day,.year,.month], from: Date())
    }()
    
    static var previews: some View {
        EMCalendar(date: .constant(DateComponents()))
            .background(Color.theme.primary)
            .previewLayout(.sizeThatFits)
            .frame(height: 430)
    }
}
