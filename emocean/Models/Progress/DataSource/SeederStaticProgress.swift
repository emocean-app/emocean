//
//  SeederStaticProgress.swift
//  emocean
//
//  Created by Farrel Anshary on 25/08/21.
//

import Foundation

struct SeederStaticProgress {
    func getProgress() -> Progress {
        return Progress(
            progress: [
                Quadrant(quadrant: "yellow", count: 4),
                Quadrant(quadrant: "blue", count: 1),
                Quadrant(quadrant: "red", count: 1)
            ],
            mood: SeederStaticMood().getData()[0],
            total: 6
        )
    }
}
