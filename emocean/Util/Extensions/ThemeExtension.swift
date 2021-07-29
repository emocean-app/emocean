//
//  LinearGradientExtension.swift
//  emocean
//
//  Created by Puras Handharmahua on 29/07/21.
//

import Foundation
import SwiftUI

/// Application Theme
///
/// ```
/// EMTheme.shared.morning
/// EMTheme.shared.night
/// EMTheme.shared.sunset
/// EMTheme.shared.sea
/// EMTheme.shared.noon
/// ```
///
class EMTheme {
    
    static let shared = EMTheme()
    
    let morning = LinearGradient(
        gradient: Gradient(colors: [Color.theme.morningTopGradient, Color.theme.morningBottomGradient]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    let night = LinearGradient(
        gradient: Gradient(colors: [Color.theme.nightTopGradient, Color.theme.nightBottomGradient]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    let sunset = LinearGradient(
        gradient: Gradient(colors: [Color.theme.sunsetTopGradient, Color.theme.sunsetBottomGradient]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    let sea = LinearGradient(
        gradient: Gradient(colors: [Color.theme.seaTopGradient, Color.theme.seaBottomGradient]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    let noon = Color.theme.morningTopGradient
}
