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
    let deviceId = UIDevice.current.identifierForVendor!.uuidString
    let content: String
    let completed: Bool
    let createdAt: String
    let categoryId: Int
    
}

struct Goalpost: Codable {
    let deviceId: String
    let content: String
    let categoryId: Int
}


