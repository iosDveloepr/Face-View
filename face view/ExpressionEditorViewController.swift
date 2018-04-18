//
//  ExpressionEditorViewController.swift
//  face view
//
//  Created by Yermakov Anton on 20.09.17.
//  Copyright © 2017 Yermakov Anton. All rights reserved.
//

import UIKit

class ExpressionEditorViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var eyesControl: UISegmentedControl!
    @IBOutlet weak var mouthControl: UISegmentedControl!
    
    var name : String{
        return nameTextField?.text ?? ""
    }
    
    var expression : Model{
       return Model(
        eyes: eyeChoises[eyesControl?.selectedSegmentIndex ?? 0],
        mouth: mouthChoises[mouthControl?.selectedSegmentIndex ?? 0]
        )}
    
    private let eyeChoises = [Model.Eyes.closed, .open, .squinting]
    private let mouthChoises = [Model.Mouth.frown, .smirk, .neutral, .grin, .smile]

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        presentedViewController?.dismiss(animated: true)
    }
    
    @IBAction func updateFace(_ sender: UISegmentedControl) {
        faceViewController?.faceExpression = expression
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return tableView.bounds.size.width
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private var faceViewController : BlincingFaceViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "faceView"{
            faceViewController = segue.destination as? BlincingFaceViewController
            faceViewController?.faceExpression = expression
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let popoverPresentationController = navigationController?.popoverPresentationController{
            if popoverPresentationController.arrowDirection != .unknown{
                navigationItem.leftBarButtonItem = nil
            }
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "addEmotion", name.isEmpty{
            handleUnnamedface()
            return false
        } else {
            return super.shouldPerformSegue(withIdentifier: identifier, sender: sender)
        }
    }
    
    private func handleUnnamedface(){
        let alert = UIAlertController(title: "Add face name", message: "Face name is empty", preferredStyle: .alert)
           alert.addTextField(configurationHandler: nil)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
              self.nameTextField.text = alert.textFields?.first?.text
              self.performSegue(withIdentifier: "addEmotion", sender: nil)
        }))
        present(alert, animated: true)
    }

    
    
}




