//
//  CheckinPromptView.swift
//  emocean
//
//  Created by Puras Handharmahua on 06/08/21.
//
import SwiftUI

struct CheckinPromptView: View {
    
    @EnvironmentObject var env: CheckinViewModel
    
    @State private var sec = 0.0
    private var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Spacer()
            Text(env.getQuestion())
                .foregroundColor(.white)
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding()
            Spacer()
        }
        .onReceive(timer, perform: { _ in
            if sec == 2.5 {
                sec = 0.0
                env.goToNextStep(isYes: true)
                self.timer.upstream.connect().cancel()
            } else {
                sec += 0.5
            }
        })
    }
}

struct CheckinPromptView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinPromptView()
    }
}
