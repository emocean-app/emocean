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
    @State private var showTextField: Bool = false
    @State private var text: String = ""
    @State private var sec = 0.0
    var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()

    // MARK: BODY
    var body: some View {
        ZStack { // START: ZTACK
            
            VStack(alignment: .center) { // START: VSTACK
                Spacer(minLength: 35)
                
                Text(env.getQuestion())
                    .frame(maxWidth: .infinity, minHeight: 110, alignment: .bottom)
                    .padding()
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                if showTextField {
                    MultilineTextField(text: $text, onCommit: {
                        print("Final text: \(text)")
                        if !text.isEmpty {
                            env.saveFeedback(answer: text)
                            env.goToNextStep(isYes: true)
                        }
                    })
                    .padding(.horizontal)
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
        .onReceive(timer, perform: { _ in
            if sec == 2.5 {
                withAnimation(.easeInOut) {
                    showTextField = true
                }
                timer.upstream.connect().cancel()
                sec = 0.0
            } else {
                sec += 0.5
            }
        })
    }
}

struct CheckinDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinDescriptionView()
            .background(EMTheme.shared.sea.ignoresSafeArea())
    }
}
