//
//  BlincingFaceViewController.swift
//  face view
//
//  Created by Yermakov Anton on 14.09.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class BlincingFaceViewController: FaceViewController {

    var blinking = false{
        didSet{
            blinkingIfNeeded()
        }
    }
    
    override func updateUI() {
        super.updateUI()
        blinking = faceExpression.eyes == .squinting
    }
    
    private struct BlinkingRate{
       static let closedEyes : TimeInterval = 0.6
       static let openEyes : TimeInterval = 2.5
    }
    
    private var canBlink = false
    private var inAAblinK = false
    
    private func blinkingIfNeeded(){
        if blinking && canBlink && !inAAblinK{
            faceView.eyesIsOpen = false
            inAAblinK = true
            Timer.scheduledTimer(withTimeInterval: BlinkingRate.closedEyes, repeats: false, block: { [weak self] finished in
                self?.faceView.eyesIsOpen = true
                Timer.scheduledTimer(withTimeInterval: BlinkingRate.openEyes, repeats: false, block: { finished in
                    self?.inAAblinK = false
                    self?.blinkingIfNeeded()
                })
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         canBlink = true
         blinkingIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        canBlink = false
    }
}
