//
//  ViewController.swift
//  Assignment2
//
//  Created by Bari Abdul on 10/6/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var billAmount:Double = 0.0 {       //this is the value that will be entered in the text field and set to default 0
        didSet{
            configureView()     //calling the didSet, which is a property observer calls the configureView where the modifications for all the output labels takes place
        }
    }

    var tipPercentage = 20 {        //this is the tip percentage and is set to default and changing this will change the bill amount according to the tip percentage
        didSet{
            configureView()
        }
    }

    var partySize = 1 {         //this is the number of members which is set to 1 as default. changing this slider will basically split the bill into the number of members
        didSet{
            configureView()
        }
    }

    @IBOutlet weak var TextField: UITextField!      //declare all the labels, textfields, buttons and sliders here
   
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var TipLabel: UILabel!
    
    @IBOutlet weak var party1Label: UILabel!
    @IBOutlet weak var party1lable2: UILabel!
    
    @IBOutlet weak var slider1: UISlider!
    
    @IBOutlet weak var slider2: UISlider!
   
    //num.numberStyle  = NSNumberFormatterStyle.CurrencyStyle

    @IBAction func Click(sender: UIButton) {        //this is the action to be taken when the button is pressed
        view.endEditing(true)       //hide the keyboard when it is pressed
        
        let newbill = TextField.text
        if !newbill!.isEmpty{
            billAmount = Double(TextField.text!)!
        }
        
        else{
            billAmount = 0.00
        }
              //read the string as a double to easily perform the operations
        //billAmount += billAmount*per
        //let str = TextField.text
        //billAmount = CGFloat(str!)
    }
    
    
    @IBAction func tipSlider(sender: UISlider) {
  
         tipPercentage = Int(sender.value) * 5      //as the min and max value for tip is set from 0 to 8, multiplying it with 5 gives a max of tip 40%
        
        /*
        let k = NSNumberFormatter()
        
        k.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        
        
        
        var tipComponent : Int = Int(sender.value)
        
        if sender == slider1{
            tipComponent = Int(sender.value)
            tipComponent*=5
            percentLabel.text = "\(tipComponent)%"
            
        }
        
        
        let fieldValue = TextField.text
        
        var value = Float(fieldValue!)
        
        let per = Float(tipComponent / 100)
        
        value = value! * per
        
        TipLabel.text = k.stringFromNumber(value!)
*/
    }
    
    
    
    @IBAction func partySlider(sender: UISlider) {
        partySize = Int(sender.value)       //this a normal slider set from 1 to 10
        /*
        if sender == slider2{
        partyComponent = Int(sender.value)
        party1Label.text = "\(partyComponent)"
        }*/
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//this whole chunk of code is responsible for error checking and not allowing the user to enter invalid characters apart from numbers
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var textAfterUpdate: NSString = textField.text! as NSString
        textAfterUpdate = textAfterUpdate.stringByReplacingCharactersInRange(range,
                                                                             withString: string)
        let newString = String(textAfterUpdate)
        
        if newString.isEmpty || newString == "-" { return true
        }
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        if let _ = numberFormatter.numberFromString(newString) { return true
        } else {
            return false
        } }
    
    //this function dismisses the keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
    TextField.resignFirstResponder()
        return true
    }

   //this also dismisses the keyboard when the background is tapped
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    //this code is used for having all kinds of orientations including the upside down
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return.All
    }
    
    func configureView(){
        // Update output label text
        let k = NSNumberFormatter()     //decalre a number formatter to display output in currency style
        
        k.numberStyle = NSNumberFormatterStyle.CurrencyStyle        //set the variable to currency style
        
        percentLabel.text = "\(tipPercentage)%"     //display the input sliders value which shows the percentage
            
        party1Label.text = "\(partySize)"       //display the number of members which is displayed on the left slide of the bottom slider
        
        //let fieldValue = TextField.text
        
        
        
       let per = Double(tipPercentage) / 100.0      //these are the calculations to be performed on the billamount
        //
       let finalamount = billAmount + (billAmount * per)
        //
        //TipLabel.text = "$\(finalamount)"
        TipLabel.text = k.stringFromNumber(finalamount)
        
        let split :Double
        split = finalamount/Double(partySize)
        
        //party1lable2.text = "$\(split)"
        party1lable2.text = k.stringFromNumber(split)
    
    }
    
    }
    


