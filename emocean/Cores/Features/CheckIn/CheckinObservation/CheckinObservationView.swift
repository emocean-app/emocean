//
//  CheckinObservationView.swift
//  emocean
//
//  Created by Christian Adiputra on 27/07/21.
//
/// CheckinObservation
///
///
/// - Parameter question: The question for CheckinObservationView
///
import SwiftUI

struct CheckinObservationView: View {
    
    // MARK: PROPERTIES
    @EnvironmentObject var env: CheckinViewModel
    let time = Time()
    
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZTACK
            VStack(alignment: .center) { // START: VSTACK
                Spacer()
                Text(env.currentStep.question.texts[0])
                    .frame(maxWidth: .infinity)
                    .padding()
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
                HStack { // START: HSTACK
                    PrimaryButton(content: {
                        Text("No")
                    }, maxWidth: 65, action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            env.goToNextStep(isYes: false)
                        }
                    })
                    PrimaryButton(content: {
                        Text("Yes")
                    }, maxWidth: 65, action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            env.goToNextStep(isYes: true)
                        }
                    })
                }.padding(.bottom, 30) // END: HSTACK
            } // END: VSTACK
        } // END: ZTACK
    }
}

struct CheckinObservationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinObservationView()
    }
}
