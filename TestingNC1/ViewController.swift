//
//  ViewController.swift
//  TestingNC1
//
//  Created by George Joseph Kristian on 19/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var objectTarget: UIView!
    var initialCenter = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func objectControllerSwiped(_ gestureRecognizer : UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: view)
        var isRight = true
        switch gestureRecognizer.state {
        case .began, .changed:
            print(translation.x)
            translation.x < 0 ? (isRight = false) :
                (isRight = true)
            objectTarget.moveObject(isRight: isRight)
        case .ended:
            break
        default:
            break
        }
    }
}

extension UIView {
    func moveObject(isRight: Bool) {
        UIView.animate(withDuration: 0, animations: {
            isRight ? (self.center.x += 1) : (self.center.x -= 1)
        })
    }
}

