//
//  CheckinDescriptionView.swift
//  emocean
//
//  Created by Wilson Adrilia on 01/08/2021.
//

import SwiftUI

struct CheckinDescriptionView: View {
    // MARK: PROPERTIES
    
    @EnvironmentObject var env: CheckinViewModel
    
    var question: String
    @State private var showTextField: Bool = false
    @State private var text: String = ""

    // MARK: BODY   
    var body: some View {
        ZStack { // START: ZTACK
            
            VStack(alignment: .center) { // START: VSTACK
                Spacer()
                
                Text(question)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                if showTextField {
                    MultilineTextField(text: $text, onCommit: {
                        print("Final text: \(text)")
                        env.answers.append(text)
                    })
                    .padding()
                }
                
                Spacer()
            }    .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            ) // END: VSTACK
            
        } // END: ZTACK
        .onAppear(perform: {
            withAnimation(.easeInOut.delay(5)) {
                showTextField = true
            }
        })
    }
}

struct CheckinDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinDescriptionView(question: "Lorem ipsum dolor sit amet")
            .background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
