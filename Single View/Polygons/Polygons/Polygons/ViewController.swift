//
//  ViewController.swift
//  Polygons
//
//  Created by Kurt McMahon on 11/8/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

protocol PolygonViewDelegate: class {
    func numberOfSides() -> Int
}

class ViewController: UIViewController, PolygonViewDelegate {

    @IBOutlet weak var numberOfSidesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var polygonView: PolygonView!
    
    var polygon: PolygonShape = PolygonShape()

    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        becomeFirstResponder()
        
        polygonView.delegate = self
        
        // Attempt to retrieve stored user defaults
        retrieveUserDefaults()
        
        // Update user interface with initial values for polygon.
        updateUI()
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            polygonView.reset()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: ViewController methods
    
    // When the Stepper is pressed, update the polygon's number of sides
    @IBAction func stepperPressed(sender: UIStepper) {
        polygon.numberOfSides = Int(sender.value)
        updateUI()
    }
    
    // Update the user interface with the new number of sides.
    func updateUI() {
        nameLabel.text = polygon.name
        numberOfSidesLabel.text = "\(polygon.numberOfSides)"
        print(polygon.description())
        polygonView.setNeedsDisplay()
    }
    
    // Retrieve stored number of sides
    func retrieveUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let n = defaults.integerForKey("Number of Sides")
        if n != 0 {
            polygon.numberOfSides = n
        }
    }
    
    // Save the number of sides
    func saveUserDefaults() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(polygon.numberOfSides, forKey: "Number of Sides")
    }
    
    // MARK: PolygonViewDelegate methods.
    
    func numberOfSides() -> Int {
        return polygon.numberOfSides
    }
}

