//
//  emoceanApp.swift
//  emocean
//
//  Created by Mughie Arief Mughoni on 21/07/21.
//

import SwiftUI

@main
struct EmoceanApp: App {
    @State var isLaunchScreen = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLaunchScreen {
                    LaunchScreenView()
                } else {
                    TabBarView()
                }
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut) {
                        isLaunchScreen = false
                    }
                }
            })
        }
    }
}
