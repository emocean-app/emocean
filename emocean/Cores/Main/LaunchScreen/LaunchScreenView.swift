//
//  LaunchScreenView.swift
//  emocean
//
//  Created by Farrel Anshary on 17/08/21.
//

import SwiftUI

struct LaunchScreenView: View {
    private let time = Time()
    var body: some View {
        Image("Launch\(time.getRawValue())")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .edgesIgnoringSafeArea(.all)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
