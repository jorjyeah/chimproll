//
//  BananaEmitter.swift
//  TestingNC1
//
//  Created by George Joseph Kristian on 24/05/19.
//  Copyright © 2019 George Joseph Kristian. All rights reserved.
//

import UIKit

class BananaEmitter {
    static func get(with image: UIImage, emissionLongitudeDegree: Float) -> CAEmitterLayer{
        let bananaEmitter = CAEmitterLayer()
        bananaEmitter.emitterShape = CAEmitterLayerEmitterShape.line
        bananaEmitter.emitterCells = generateEmitterCells(image: image, emissionLongitudeDegree: emissionLongitudeDegree)
        
        return bananaEmitter
    }
    
    static func generateEmitterCells(image: UIImage, emissionLongitudeDegree: Float) -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()
        
        let cell = CAEmitterCell()
        cell.contents = image.cgImage
        cell.birthRate = 80
        cell.lifetime = 5
        cell.velocity = CGFloat(80)
//        cell.duration = 5
        
        cell.emissionLongitude = emissionLongitudeDegree == 0.0 ? 0.0 : CGFloat((emissionLongitudeDegree * (.pi/180)))
        cell.emissionRange = (90 * (.pi/180))
        
        cell.scale = 0.3
        cell.scaleRange = 0.2
        
        cells.append(cell)
        return cells
    }
}
