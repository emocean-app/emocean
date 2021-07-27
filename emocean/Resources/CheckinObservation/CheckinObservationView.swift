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
    
    
    // MARK: BODY
    var body: some View {
        
        ZStack { // START: ZTACK
            
            Image("dummy1") /// - Background Image
                .resizable()
                .ignoresSafeArea()
                
                VStack(alignment: .center) { // START: VSTACK
                    
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
