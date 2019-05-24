//
//  ViewController.swift
//  TestingNC1
//
//  Created by George Joseph Kristian on 19/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate, AVAudioPlayerDelegate {

    
    @IBOutlet weak var curtainTop: UIImageView!
    @IBOutlet weak var curtainBottom: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var moodIndicator: UIView!
    @IBOutlet weak var chimpImage: UIImageView!
    @IBOutlet weak var word: UIImageView!
    
    var lastRotation: CGFloat = 0
    var counterPerRotation = 0.0
    var moodLevel: Double = 0.0
    let audioCollection = AudioCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chimpImage.image = UIImage(named: "chimp_stay")
        curtainTop.image = UIImage(named: "top_curtain")
        curtainBottom.image = UIImage(named: "bottom_curtain")
        moodIndicator.layer.cornerRadius = moodIndicator.frame.size.width/2
        moodIndicator.clipsToBounds = true
        moodIndicator.layer.borderWidth = 10
        moodIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        moodIndicator.layer.borderColor = #colorLiteral(red: 0.8858358305, green: 0.5235362993, blue: 0.4429179152, alpha: 1)
        word.image = UIImage(named: "roll")
        background.backgroundColor = #colorLiteral(red: 1, green: 0.9496994592, blue: 0.7835138326, alpha: 1)
        audioCollection.stopPlayingAudio()
        audioCollection.chimpStay.playAudio()
        
        bananaConfetti()
        
        let pan = UIPanGestureRecognizer(target: self, action:#selector(self.pan))
        
        pan.minimumNumberOfTouches = 1
        pan.maximumNumberOfTouches = 1
        
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: [.curveEaseInOut, .autoreverse , .repeat], animations: {
            self.word.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
    }
    
    func angle(from location: CGPoint) -> CGFloat {
        let deltaY = location.y - view.center.y
        let deltaX = location.x - view.center.x
        let angle = atan2(deltaY, deltaX) * 180 / .pi
        counterPerRotation += 0.1
        return angle < 0 ? abs(angle) : 360 - angle
    }
    
    fileprivate var rotation: CGFloat = UserDefaults.standard.rotation
    fileprivate var startRotationAngle: CGFloat = 0
    @objc func pan(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: view)
        let gestureRotation = CGFloat(angle(from: location)) - startRotationAngle
        
        switch gesture.state {
        case .began:
            startRotationAngle = angle(from: location)
            moodLevel = Double .random(in: 50 ... 80)
            audioCollection.stopPlayingAudio()
            audioCollection.chimpAcrobat.playAudio()
            self.chimpImage.image = UIImage(named: "chimp_acrobat")
        case .changed:
            rotate(to: rotation - gestureRotation.degreesToRadians)
            moodIndicatorChanged()
        case .ended:
            rotation -= gestureRotation.degreesToRadians
            print(rotation)
            print(counterPerRotation)
            chimpCelebrationCheck()
            counterPerRotation = 0
        default :
            counterPerRotation = 0
        }
        UserDefaults.standard.rotation = rotation
    }
    
    fileprivate let rotateAnimation = CABasicAnimation()
    func rotate(to: CGFloat, duration: Double = 0) {
        rotateAnimation.fromValue = to
        rotateAnimation.toValue = to
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = 0
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.fillMode = CAMediaTimingFillMode.forwards
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        chimpImage.layer.add(rotateAnimation, forKey: "transform.rotation.z")
    }
    
    @IBAction func backToOpening(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func moodIndicatorChanged(){
        if self.counterPerRotation < self.moodLevel*0.4{
            self.word.image = UIImage(named: "roll")
            self.moodIndicator.layer.borderColor = #colorLiteral(red: 0.8858358305, green: 0.5235362993, blue: 0.4429179152, alpha: 1)
        } else if self.counterPerRotation >= self.moodLevel*0.4 && self.counterPerRotation < self.moodLevel*0.75{
            self.word.image = UIImage(named: "faster")
            self.moodIndicator.layer.borderColor = #colorLiteral(red: 1, green: 0.7878941623, blue: 0.624411387, alpha: 1)
        } else if self.counterPerRotation >= self.moodLevel*0.75 && self.counterPerRotation < self.moodLevel{
            self.moodIndicator.layer.borderColor = #colorLiteral(red: 1, green: 0.9034691654, blue: 0.6462703339, alpha: 1)
        } else if self.counterPerRotation >= self.moodLevel{
            self.moodIndicator.layer.borderColor = #colorLiteral(red: 1, green: 0.8358077748, blue: 0.3983304795, alpha: 1)
        }
    }

    func chimpCelebrationCheck(){
        audioCollection.stopPlayingAudio()
        print(self.moodLevel)
        if self.counterPerRotation >= self.moodLevel{
            // celebaration
            self.audioCollection.chimpCelebration.playAudio()
            self.audioCollection.circusCelebration.playAudio()
            self.chimpImage.image = UIImage(named: "chimp_celebration_1")
            self.word.image = UIImage(named: "yay")
            bananaConfetti()
        } else{
            // reset
            print("reseting to initial state")
            chimpImage.image = UIImage(named: "chimp_stay")
            audioCollection.chimpStay.playAudio()
            counterPerRotation = 0
            moodIndicatorChanged()
        }
    }
    
    func bananaConfetti(){
        let bananaEmitterUp = BananaEmitter.get(with: #imageLiteral(resourceName: "banana"), emissionLongitudeDegree: 0.0)
        let bananaEmitterRight = BananaEmitter.get(with: #imageLiteral(resourceName: "banana"), emissionLongitudeDegree: 90)
        let bananaEmitterLeft = BananaEmitter.get(with: #imageLiteral(resourceName: "banana"), emissionLongitudeDegree: 90)
        let bananaEmitterDown = BananaEmitter.get(with: #imageLiteral(resourceName: "banana"), emissionLongitudeDegree: 180.0)
        bananaEmitterUp.emitterPosition = CGPoint(x: view.frame.width / 2, y: 376)
        bananaEmitterUp.emitterShape = .line
        bananaEmitterUp.emitterSize = CGSize(width: 151, height: 0)
//        bananaEmitterRight.emitterPosition = CGPoint(x: view.frame.width / 2, y: 376)
//        bananaEmitterRight.emitterShape = .line
//        bananaEmitterRight.emitterSize = CGSize(width: view.frame.size.width, height: 2)
//        bananaEmitterLeft.emitterPosition = CGPoint(x: view.frame.width / 2, y: 376)
//        bananaEmitterLeft.emitterShape = .line
//        bananaEmitterLeft.emitterSize = CGSize(width: view.frame.size.width, height: 2)
        bananaEmitterDown.emitterPosition = CGPoint(x: view.frame.width / 2, y: 520)
        bananaEmitterDown.emitterShape = .line
        bananaEmitterDown.emitterSize = CGSize(width: 151, height: 2)
        view.layer.addSublayer(bananaEmitterUp)
        view.layer.addSublayer(bananaEmitterDown)
    }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension UserDefaults {
    /// rotation persistant computed property
    var rotation: CGFloat {
        get {
            return CGFloat(double(forKey: "rotation"))
        }
        set {
            set(Double(newValue), forKey: "rotation")
        }
    }
}

