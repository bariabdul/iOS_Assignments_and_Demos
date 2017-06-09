//
//  ViewController.swift
//  Dog
//
//  Created by Bari Abdul on 9/9/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dogLabel: UILabel!
    
    @IBOutlet weak var dogText: UITextField!
    
    
    @IBOutlet weak var dogImage: UIImageView!
    
    
    
    @IBAction func dogButton(sender: UIButton) {
        let dogage = dogText.text!
        if !dogage.isEmpty{
            if let numericAge = Int(dogage){
dogLabel.text = "Your dog is \(numericAge * 7) in human years"
            }
        }
        
        else{
            alert("Please enter an age for your dog")}
            
        }
    
    func alert(errorMessage: String){
        let alertController = UIAlertController(title: "Error", message: errorMessage,preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController,animated: true,completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }


}

