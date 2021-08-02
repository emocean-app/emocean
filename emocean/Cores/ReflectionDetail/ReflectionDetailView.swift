//
//  ReflectionDetailView.swift
//  emocean
//
//  Created by Puras Handharmahua on 01/08/21.
//

import SwiftUI

struct ReflectionDetailView: View {
    
    @StateObject private var vm = ReflectionDetailViewModel()
    
    var body: some View {
        ZStack {
            // Background
            Color.white
            
            //Content
            ScrollView(.vertical) {
                VStack {
                    
                    // Top Section
                    HStack {
                        Text("Thursday, June 4Th 2020")
                        Text("| Morning")
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "xmark")
                                .foregroundColor(Color.theme.grayThird)
                        })
                    }
                    Spacer(minLength: 21)
                    
                    // Header Section
                    Text("Disgusted")
                        .font(.title2)
                        .italic()
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack() {
                        CategoryLabel(labelCategory: "Work")
                        CategoryLabel(labelCategory: "Relationship")
                        Spacer()
                    }
                    Spacer()
                    
                    // Answers
                    VStack(spacing: 20) {
                        ForEach(0..<3) { item in
                            VStack {
                                Text(vm.questions[item])
                                    .font(.subheadline)
                                    .foregroundColor(Color.theme.grayThird)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(vm.answers[item])
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.vertical)
                    
                }
            }
            .padding(25)
        }
    }
}

struct ReflectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ReflectionDetailView()
    }
}
