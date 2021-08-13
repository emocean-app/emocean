//
//  CheckinPromptView.swift
//  emocean
//
//  Created by Puras Handharmahua on 06/08/21.
//
import SwiftUI

struct CheckinPromptView: View {
    // MARK: PROPERTIES
    @EnvironmentObject var env: CheckinViewModel
    @State private var sec = 0.0
    private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    // MARK: BODY
    var body: some View {
        VStack { // START: VSTACK
            Spacer()
            Text(env.getQuestion())
                .foregroundColor(Time().timeRange == .night ? .white : Color.theme.primary)
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding()
            Spacer()
        } // END: VSTACK
        .onReceive(timer, perform: { _ in  // START: ON-RECIEVE
            if sec == Double(2.5) {
                sec = 0.0
                env.goToNextStep(isYes: true)
                self.timer.upstream.connect().cancel()
            } else {
                sec += 0.5
            }
        }) // END: ON-RECIEVE
    }
}

// MARK: - PREVIEW
struct CheckinPromptView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinPromptView()
    }
}