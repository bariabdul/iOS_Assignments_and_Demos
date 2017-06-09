//
//  ViewController.swift
//  Dog Age
//
//  Created by Kurt McMahon on 9/8/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var dogAgeTextField: UITextField!
    @IBOutlet weak var humanAgeLabel: UILabel!
    
    // MARK: Actions
    
    @IBAction func findAge(sender: UIButton) {
        
        // Dismiss keyboard
        
        dogAgeTextField.resignFirstResponder()
        
        // Get string from text field
        
        let dogAgeString = dogAgeTextField.text!
        
        // If string is empty, display error message and return
        
        if dogAgeString.isEmpty {
            let alertController = UIAlertController(title: "Error", message: "Please enter an age for your dog", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        // Compute dog's age in human years
        
        let dogAge: Int! = Int(dogAgeString)
        var humanAge: Int
        
        if dogAge == 1 {
            humanAge = 15
        } else if dogAge == 2 {
            humanAge = 24
        } else {
            humanAge = 24 + (dogAge - 2) * 5
        }
        
        // Display age
        
        humanAgeLabel.text = "Your dog is \(humanAge) in human years"
    }
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UIResponder methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

}

