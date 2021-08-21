//
//  WeeklySkyBackground.swift
//  emocean
//
//  Created by Puras Handharmahua on 21/08/21.
//

import SwiftUI

struct WeeklySkyBackground: View {
    private let time = Time()
    
    var body: some View {
        LottieView(
            filename: "\(time.getRawValue())Ending",
            contentMode: .scaleAspectFit
        )
            .ignoresSafeArea()
    }
}

struct WeeklySkyBackground_Previews: PreviewProvider {
    static var previews: some View {
        WeeklySkyBackground()
    }
}
