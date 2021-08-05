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
    @Binding var question: String
    let time = Time()
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZTACK
            VStack(spacing: -1){
                Image("Up\(time.getRawValue())") /// - Background Image
                    .resizable()
                    .scaledToFit()
                    .padding(.top,0)
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]), startPoint: .top, endPoint: .bottom)
                    )
                ZStack {
                    Image("BackCoral") /// - Background Image
                        .resizable()
                        .scaledToFit()
                        .padding(.top,0)
                    Image("FrontCoral") /// - Background Image
                        .resizable()
                        .scaledToFit()
                        .padding(.top,0)
                }
                .background(Color.theme.seaBottomGradient)
                .ignoresSafeArea()
            }.ignoresSafeArea()
            VStack(alignment: .center) { // START: VSTACK d
                Spacer()
                Text(question)
                    .padding()
                    .font(.title)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                Spacer()
                HStack { // START: HSTACK
                    PrimaryButton(content: {
                        Text("No")
                    }, maxWidth: 65, action: {})
                    PrimaryButton(content: {
                        Text("Yes")
                    }, maxWidth: 65, action: {})
                }.padding(.bottom, 30) // END: HSTACK
            } // END: VSTACK
        } // END: ZTACK
    }
}

struct CheckinObservationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinObservationView(question: .constant("Do you wanna talk about it?"))
    }
}
