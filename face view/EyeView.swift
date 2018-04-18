//
//  EyeView.swift
//  face view
//
//  Created by Yermakov Anton on 17.09.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class EyeView: UIView {

    var lineWidth : CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    var color : UIColor = .blue { didSet {setNeedsDisplay() } }
    var _eyesOpen : Bool = true { didSet { setNeedsDisplay() } }
    
    var eyesOpen : Bool{
        get{
            return _eyesOpen
        } set {
            if newValue != _eyesOpen{
                UIView.transition(with: self, duration: 0.4, options: [.transitionFlipFromBottom], animations: {
                    self._eyesOpen = newValue
                })
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        var path: UIBezierPath
        if eyesOpen{
            path = UIBezierPath.init(ovalIn: bounds.insetBy(dx: lineWidth/2, dy: lineWidth/2))
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
            path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        }
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()
    }
}
