//
//  CheckinDescriptionView.swift
//  emocean
//
//  Created by Wilson Adrilia on 01/08/2021.
//

import SwiftUI

struct CheckinDescriptionView: View {
    // MARK: PROPERTIES
    @Binding var question: String
    static var test:String = ""
    static var testBinding = Binding<String>(get: { test }, set: {
        test = $0 })

    // MARK: BODY
    var body: some View {
        ZStack { // START: ZTACK
            Image("dummy1") /// - Background Image
                .resizable()
                .ignoresSafeArea()
                VStack(alignment: .center) { // START: VSTACK
                    Spacer().frame(minHeight: 10, maxHeight: 50)
                    Text(question)
                        .padding()
                        .font(.title)
                        .lineLimit(nil)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.red)
                    Spacer().frame(minHeight: 10, maxHeight: 50)
                    MultilineTextField(text: CheckinDescriptionView.testBinding, onCommit: {
                        print("Final text: \(CheckinDescriptionView.test)")
                    }).padding()
                }    .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                  ) // END: VSTACK
        } // END: ZTACK
    }
}

struct CheckinDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinDescriptionView(question: .constant("Do you wanna talk about it?"))
    }
}
