//
//  ColorExtension.swift
//  emocean
//
//  Created by Puras Handharmahua on 29/07/21.
//

import SwiftUI
import Foundation

extension Color {
    static let theme = EMColorTheme()
}

struct EMColorTheme {
    let blueQuadrant = Color("BlueQuadrant")
    let calendarBullet3 = Color("CalendarBullet3")
    let greenQuadrant = Color("GreenQuadrant")
    let morningTopGradient = Color("MorningTopGradient")
    let morningBottomGradient = Color("MorningBottomGradient")
    let nightTopGradient = Color("NightTopGradient")
    let nightBottomGradient = Color("NightBottomGradient")
    let sunsetTopGradient = Color("SunsetTopGradient")
    let sunsetBottomGradient = Color("SunsetBottomGradient")
    let primary = Color("Primary")
    let grayPrimary = Color("PrimaryGray")
    let redQuadrant = Color("RedQuadrant")
    let seaBottomGradient = Color("SeaBottomGradient")
    let seaTopGradient = Color("SeaTopGradient")
    let graySecondary = Color("SecondaryGray")
    let grayThird = Color("ThirdGray")
    let yellowQuadrant = Color("YellowQuadrant")
}
