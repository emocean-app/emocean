//
//  SeederStaticMood.swift
//  emocean
//
//  Created by Puras Handharmahua on 05/08/21.
//

import Foundation

struct SeederStaticMood {
    func getData() -> [Mood] {
        return [
            Mood(id: 1, name: "Despairing", description: "Feeling extreme dislike or disapproval of something", imageUrl: "ArwanaDua", energy: 1, pleasent: 1),
            Mood(id: 2, name: "Despondent", description: "Ending to see the worst aspect of things or believe that the worst will happen", imageUrl: "ArwanaDua", energy: 2, pleasent: 1),
            Mood(id: 3, name: "Alienated", description: "Feeling that you have no connection with the people around or not part of a group", imageUrl: "ArwanaDua", energy: 3, pleasent: 1)
        ]
    }
}
