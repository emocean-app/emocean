//
//  SoundPlayer.swift
//  emocean
//
//  Created by Christian Adiputra on 09/08/21.
//

import Foundation
import AVKit

class SoundManager {
    static let shared = SoundManager()
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case ocean
        case backsong
        case water
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 
            player?.play()
        } catch let error {
            print("Error playing sound")
        }
    }
    
    func stopSound(sound: SoundOption){
        guard let player = player else { return }
        player.stop()
    }
}
