//
//  ViewController.swift
//  face view
//
//  Created by Yermakov Anton on 17.07.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class FaceViewController: VCLLoggingViewController {
    
    var faceExpression = Model(eyes: .open, mouth: .neutral){
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: ViewX!{
        didSet{
            
            
            let handler = #selector(ViewX.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            /*
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector (toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 2
            faceView.addGestureRecognizer(tapRecognizer)
            */
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappier))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            let swipeDownRecognier = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeDownRecognier.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognier)
            
            let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(changeColor(byReactingTo:)))
            longRecognizer.minimumPressDuration = 1.0
            faceView.addGestureRecognizer(longRecognizer)
            
            updateUI()
        }
    }
    
    @IBAction func blincingFaceRecognizer(_ sender: UITapGestureRecognizer) {
        headShake()
    }
    
    private struct HeadShakeData{
       static let angel = CGFloat.pi / 6
       static let timeDuration : TimeInterval = 0.6
    }
    
    private func rotatedBy(by angel: CGFloat){
        faceView.transform = faceView.transform.rotated(by: angel)
    }
    
    private func headShake(){
        UIView.animate(withDuration: HeadShakeData.timeDuration, animations: {
            self.rotatedBy(by: HeadShakeData.angel)
        }) { finished in
            if finished {
                UIView.animate(withDuration: HeadShakeData.timeDuration, animations: {
                    self.rotatedBy(by: -HeadShakeData.angel * 2)
                }, completion: { finished in
                    if finished{
                        UIView.animate(withDuration: HeadShakeData.timeDuration, animations: {
                            self.rotatedBy(by: HeadShakeData.angel)
                        })
                    }
                })
            }
        }
    }
    
    func changeColor(byReactingTo longRecognizer: UILongPressGestureRecognizer){
        if longRecognizer.state == .ended{
            if faceView.color == .black{
                faceView.color = .blue
            } else {
                faceView.color = .black
            }
            
            if faceView.lineWidth == 5.0{
                faceView.lineWidth = 10.0
            } else {
                faceView.lineWidth = 5.0
            }
        }
    }
   
   /*
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes : Model.Eyes = (faceExpression.eyes == .closed) ? .open : .closed
            faceExpression = Model(eyes: eyes, mouth: faceExpression.mouth)
        }
    }
 */

    
    func increaseHappiness(){
        faceExpression = faceExpression.happier
    }
    
    func decreaseHappier(){
        faceExpression = faceExpression.sadder
    }
    
     func updateUI() {
        switch faceExpression.eyes{
        case .open:
            faceView?.eyesIsOpen = true
        case .closed:
            faceView?.eyesIsOpen = false
        case .squinting:
            //  faceView?.eyesIsOpen = false
            break
        }
        faceView?.mouthCurvatures = mouthCurvatures[faceExpression.mouth] ?? 0.0
    }
  
    var mouthCurvatures = [Model.Mouth.frown : -1.0, .smirk : -0.5, .neutral : 0.0, .grin : 0.5, .smile : 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

  

}

