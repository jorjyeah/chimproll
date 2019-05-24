//
//  AudioPlayerClass.swift
//  TestingNC1
//
//  Created by George Joseph Kristian on 22/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import AVFoundation

class AudioPlayerClass{
    var player: AVAudioPlayer!
    
    init(audioName: String, fileFormat: String, infiniteLoops: Bool) {
        let audioURL = Bundle.main.url(forResource: audioName, withExtension: fileFormat)
        do{
            player = try AVAudioPlayer(contentsOf: audioURL!)
        }
        catch{
            print(error)
        }
        
        if infiniteLoops{
            player.numberOfLoops = 100
        }
    }
    
    func playAudio() {
        player.play()
    }
    
    func stopAudio() {
        player.stop()
    }
    
    func isPlaying() -> Bool {
        return player.isPlaying
    }
}
