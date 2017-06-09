//
//  ViewController.swift
//  TextFieldExample
//
//  Created by Kurt McMahon on 9/2/16.
//  Copyright © 2016 Kurt McMahon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    
    @IBAction func buttonPressed(sender: UIButton) {
        let temperature = inputTextField.text!
        if !temperature.isEmpty {
            if let numericTemperature = Int(temperature) {
                outputLabel.text = "The temperature plus 10 degrees is \(numericTemperature + 10)"
            } else {
                alert("Please enter a valid temperature.")
            }
        } else {
            alert("Please enter a temperature.")
        }
    }
    
    func alert(errorMessage: String) {
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: UIResponder methods
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
}

