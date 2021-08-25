//
//  History.swift
//  emocean
//
//  Created by Farrel Anshary on 23/08/21.
//

import Foundation

struct History: Codable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id, mood, category, stories, createdAt
    }
    
    let id: Int
    let mood: Mood
    let category: Category
    var stories: [Story]
    let createdAt: DateComponents
    let createdDate: Date
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.mood = try container.decode(Mood.self, forKey: .mood)
        self.category = try container.decode(Category.self, forKey: .category)
        self.stories = try container.decode([Story].self, forKey: .stories)
        
        let date = try container.decode(String.self, forKey: .createdAt)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        self.createdDate = formatter.date(from: date) ?? Date()
        self.createdAt = Calendar.current.dateComponents([.hour, .day, .month, .year], from: self.createdDate)
    }
}

struct Story: Codable {
    let story: String
    let question: Question
}
