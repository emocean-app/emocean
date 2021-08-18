//
//  Goal.swift
//  emocean
//
//  Created by Christian Adiputra on 12/08/21.
//

import Foundation
import SwiftUI

struct Goal: Codable, Identifiable {
    
    let id: Int
    var deviceID = UIDevice.current.identifierForVendor!.uuidString
    let content: String
    let category: Category?
    let createdAt: String
    let completed: Bool
    
}
