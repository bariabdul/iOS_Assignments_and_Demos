//
//  ViewController.swift
//  Survey
//
//  Created by Kurt McMahon on 10/9/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var resultsView: UITextView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!

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
        view.endEditing(true)
    }
    
    // MARK: UITextFieldDelegate methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions
    
    @IBAction func storeSurvey(sender: UIButton) {
        
        let csvLine = "\(firstName.text),\(lastName.text),(email.text)"
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = paths[0]
        let surveyFile = (docDir as NSString).stringByAppendingPathComponent("surveyresults.csv")
        
        if NSFileManager.defaultManager().fileExistsAtPath(surveyFile){
        NSFileManager.defaultManager().createFileAtPath(surveyFile, contents: nil, attributes: nil)
        }
        
        let fileHandle = NSFileHandle(forUpdatingAtPath: surveyFile)!
        fileHandle.seekToEndOfFile()
        fileHandle.writeData(csvLine.dataUsingEncoding(NSUTF8StringEncoding)!)
        fileHandle.closeFile()
        
        firstName.text = ""
        lastName.text = ""
        email.text = ""
    }
    
    @IBAction func showResults(sender: UIButton) {
        
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let docDir = paths[0]
        let surveyFile = (docDir as NSString).stringByAppendingPathComponent("surveyresults.csv")
        
        if NSFileManager.defaultManager().fileExistsAtPath(surveyFile){
            let fileHandle = NSFileHandle(forReadingAtPath: surveyFile)!
            let surveyResults = NSString(data: fileHandle.availableData, encoding: NSUTF8StringEncoding)! as String
        fileHandle.closeFile()
        resultsView.text = surveyResults
        }
    }
}

