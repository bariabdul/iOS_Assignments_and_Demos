//
//  ViewController.swift
//  Primes
//
//  Created by Kurt McMahon on 10/27/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var primesTextView: UITextView!
    
    var primesArray = [String]()
    let maxNum = 50000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startButtonPressed(sender: AnyObject) {
        
        primesArray.removeAll(keepCapacity: true)
        
        let startTime = NSDate().timeIntervalSinceReferenceDate
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)) {
            var foundDivisor: Bool
            
            for i in 2...self.maxNum {
                foundDivisor = false
                
                var divisor = i - 1
                
                while divisor > 1 && !foundDivisor {
                    if i % divisor == 0 {
                        foundDivisor = true
                    }
                    
                    divisor -= 1
                }
                
                if !foundDivisor {
                    self.primesArray.append("Prime: \(i)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.statusLabel.text = "Prime: \(i)"
                    }
                }
            }
            
            // All primes have been found.
            dispatch_async(dispatch_get_main_queue()) {
                let stopTime = NSDate().timeIntervalSinceReferenceDate
                let elapsedTime = stopTime - startTime
                
                self.statusLabel.text = "Done: elapsed time = \(elapsedTime)"
                self.showButton.enabled = true
            }
        }
    }
    
    @IBAction func clearButtonPressed(sender: AnyObject) {
        statusLabel.text = ""
        timeLabel.text = ""
        primesTextView.text = ""
        
        showButton.enabled = false
    }
    
    @IBAction func timeButtonPressed(sender: AnyObject) {
        timeLabel.text = NSDate().description
    }
    
    @IBAction func showButtonPressed(sender: AnyObject) {
        
        var primesList = "Number of primes: \(primesArray.count)\n"
        
        for primeNumber in primesArray {
            primesList = primesList + "\(primeNumber)\n"
        }
        
        primesTextView.text = primesList;
        
    }
}

