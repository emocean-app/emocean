//
//  MotionManager.swift
//  emocean
//
//  Created by Farrel Anshary on 02/08/21.
//

import SwiftUI
import Foundation
import CoreMotion

enum MotionOrientation {
    case vertical
    case horizontal
    case both
}

struct ParallaxMotionModifier: ViewModifier {
    @ObservedObject var manager: MotionManager
    var magnitude: Double
    var orientation: MotionOrientation
    
    func body(content: Content) -> some View {
        switch orientation {
        case .vertical:
            content
                .offset(y: CGFloat(manager.pitch * magnitude))
        case .horizontal:
            content
                .offset(x: CGFloat(manager.roll * magnitude))
        case .both:
            content
                .offset(x: CGFloat(manager.roll * magnitude), y: CGFloat(manager.pitch * magnitude))
        }
    }
}

class MotionManager: ObservableObject {
    @Published var pitch: Double = 0.0
    @Published var roll: Double = 0.0
    
    private var manager: CMMotionManager
    
    init() {
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 1.0/60.0
        self.manager.startDeviceMotionUpdates(to: .main) { motionData, error in
            if let error = error  {
                print(error)
                return
            }
            
            if let motion = motionData {
                self.pitch = motion.attitude.pitch
                self.roll = motion.attitude.roll
            }
        }
    }
}
