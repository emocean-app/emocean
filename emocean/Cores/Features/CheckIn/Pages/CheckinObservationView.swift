//
//  CheckinObservationView.swift
//  emocean
//
//  Created by Christian Adiputra on 27/07/21.
//

import SwiftUI

struct CheckinObservationView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var env: CheckinViewModel
    @State private var sec = 0.0
    private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    // MARK: BODY
    var body: some View {
        ZStack { // START: ZTACK
        } // END: ZTACK
        .onReceive(timer, perform: { _ in  // START: ON-RECIEVE
            if sec == 2.5 {
                sec = 0.0
                withAnimation(.easeInOut(duration: 2)) {
                    env.goToNextStep(isYes: true)
                }
                self.timer.upstream.connect().cancel()
            } else {
                sec += 0.5
            }
        }) // END: ON-RECIEVE
    }
}

// MARK: - PREVIEW
struct CheckinObservationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinObservationView()
    }
}
