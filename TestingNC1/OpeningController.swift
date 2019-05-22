//
//  OpeningController.swift
//  TestingNC1
//
//  Created by George Joseph Kristian on 20/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class OpeningController: UIViewController, AVAudioPlayerDelegate{

    @IBOutlet weak var viewOpening: UIView!
    @IBOutlet weak var topCurtain: UIImageView!
    @IBOutlet weak var chimp: UIImageView!
    @IBOutlet weak var bottomCurtain: UIImageView!
//    var audioPlayer: AVAudioPlayer!
    let audioCollection = AudioCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chimp.image = UIImage(named: "title")
        topCurtain.image = UIImage(named: "top_curtain")
        bottomCurtain.image = UIImage(named: "bottom_curtain")
        viewOpening.backgroundColor = #colorLiteral(red: 1, green: 0.9594718814, blue: 0.8255729079, alpha: 1)
//        doWithAudio(audioName: "circus_celebration_sound", fileFormat: "mp3")
//        audioPlayer.numberOfLoops = 50
        animateTitle()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        view.addGestureRecognizer(tap)
        tap.numberOfTapsRequired = 1
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [.curveEaseInOut, .autoreverse , .repeat], animations: {
            self.chimp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        audioCollection.circusCelebration.playAudio()
    }
    
    @objc func handleTap(sender : UITapGestureRecognizer ) {
        guard sender.view != nil else { return }
        
        if sender.state == .ended {      // Move the view down and to the right when tapped.
            print("tapped")
//            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut, animations: {
//                self.topCurtain.center.y -= 80
//                self.topCurtain.alpha = 0
//                self.bottomCurtain.center.y += 80
//                self.bottomCurtain.alpha = 0
//                self.chimp.transform = CGAffineTransform(scaleX: 7, y: 7)
//                self.chimp.alpha = 0
//            })
//            animator.startAnimation()
            audioCollection.circusCelebration.stopAudio()
            audioCollection.chimpRollButton.playAudio()
            performSegue(withIdentifier: "segueToMainPage", sender: nil)
        }
    }
    
    
    func animateTitle(){
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [.curveEaseInOut, .autoreverse , .repeat], animations: {
            self.chimp.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
}