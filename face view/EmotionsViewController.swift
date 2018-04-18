//
//  EmotionsViewController.swift
//  face view
//
//  Created by Yermakov Anton on 24.07.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class EmotionsViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    private var faceExpression : [(name: String, expression: Model)] = [
        ("sad", Model(eyes: .closed, mouth: .frown)),
        ("happy", Model(eyes: .open, mouth: .smile)),
        ("worried", Model(eyes: .closed, mouth: .neutral))
    ]
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faceExpression.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmotionCell", for: indexPath)
        cell.textLabel?.text = faceExpression[indexPath.row].name
        return cell
    }

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let destinationView = segue.destination
       if let faceViewController = destinationView.contentViewcontroller as? FaceViewController,
           let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell)
        {
            faceViewController.faceExpression = faceExpression[indexPath.row].expression
            faceViewController.navigationItem.title = faceExpression[indexPath.row].name
       } else if destinationView is ExpressionEditorViewController{
        if let popoverPresentationController = segue.destination.popoverPresentationController{
            popoverPresentationController.delegate = self
        }
      }
    }
    
    @IBAction func addEmotionFace(from segue: UIStoryboardSegue){
        if let editor = segue.source as? ExpressionEditorViewController{
            faceExpression.append((editor.name, editor.expression))
            tableView.reloadData()
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        
        if traitCollection.verticalSizeClass == .compact{
            return .none
        } else if traitCollection.horizontalSizeClass == .compact{
            return .overFullScreen
        } else {
            return .none
        }
    }
   
    
}



extension UIViewController{

    var contentViewcontroller: UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController!
        } else {
            return self
        }
        
    }
}
