//
//  AudioCollection.swift
//  TestingNC1
//
//  Created by George Joseph Kristian on 22/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import AVFoundation

class AudioCollection{
    var chimpStay = AudioPlayerClass(audioName: "chimp_stay_sound", fileFormat: "mp3", infiniteLoops: true)
    var chimpAcrobat = AudioPlayerClass(audioName: "chimp_acrobat_sound", fileFormat: "mp3", infiniteLoops: true)
    var chimpCelebration = AudioPlayerClass(audioName: "chimp_celebration_sound", fileFormat: "mp3", infiniteLoops: true)
    var circusCelebration = AudioPlayerClass(audioName: "circus_celebration_sound", fileFormat: "mp3", infiniteLoops: true)
    var chimpRollButton = AudioPlayerClass(audioName: "chimp_roll_button_sound", fileFormat: "mp3", infiniteLoops: false)
    
    func stopPlayingAudio(){
        if chimpStay.isPlaying() {
            chimpStay.stopAudio()
        }
        if chimpRollButton.isPlaying(){
            chimpRollButton.stopAudio()
        }
        if chimpCelebration.isPlaying(){
            chimpCelebration.stopAudio()
        }
        if chimpAcrobat.isPlaying(){
            chimpAcrobat.stopAudio()
        }
        if circusCelebration.isPlaying(){
            circusCelebration.stopAudio()
        }
    }
}
