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
    }
}

// MARK: - PREVIEW
struct CheckinObservationView_Previews: PreviewProvider {
    static var previews: some View {
        CheckinObservationView()
    }
}
