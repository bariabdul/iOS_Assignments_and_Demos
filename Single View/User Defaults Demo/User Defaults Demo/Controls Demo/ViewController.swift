//
//  ViewController.swift
//  Controls Demo
//
//  Created by Kurt McMahon on 9/21/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    var backgroundRed: Float = 0.0 {
        didSet {
            configureView()
        }
    }

    var backgroundGreen: Float = 0.0 {
        didSet {
            configureView()
        }
    }
    var backgroundBlue: Float = 0.0 {
        didSet {
            configureView()
        }
    }
    
    var backgroundHidden = false {
        didSet {
            configureView()
        }
    }

    var imageName = "dog" {
        didSet {
            configureView()
        }
    }

    var imageAlpha = 1.0 {
        didSet {
            configureView()
        }
    }

    // MARK: Outlets
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageSegmentedControl: UISegmentedControl!
    @IBOutlet weak var alphaStepper: UIStepper!
    @IBOutlet weak var showBackgroundSwitch: UISwitch!
    
    // MARK: UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    // Change RGB values for backgroundView
    @IBAction func changeBackgroundColor(sender: UISlider) {
        if sender == redSlider {
            backgroundRed = sender.value
            userDefaults.setFloat(sender.value, forKey: "red")
        } else if sender == greenSlider {
            backgroundGreen = sender.value
            userDefaults.setFloat(sender.value, forKey: "green")
        } else {
            backgroundBlue = sender.value
            userDefaults.setFloat(sender.value, forKey: "blue")
        }
    }
    
    @IBAction func selectImage(sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            imageName = "dog"
        case 1:
            imageName = "cat"
        default:
            imageName = "bird"
        }
        
        userDefaults.setInteger(sender.selectedSegmentIndex, forKey: "image")
    }
    
    @IBAction func changeImageTransparency(sender: UIStepper) {
        imageAlpha = sender.value
        userDefaults.setDouble(sender.value, forKey: "alpha")
    }
    
    @IBAction func showBackground(sender: UISwitch) {
        backgroundHidden = !sender.on
        userDefaults.setBool(sender.on, forKey: "hidden")
    }
    
    // Update user interface to reflect new model values
    func configureView() {
        backgroundView.backgroundColor = UIColor(red: CGFloat(backgroundRed), green: CGFloat(backgroundGreen), blue: CGFloat(backgroundBlue), alpha: 1)
        backgroundView.hidden = backgroundHidden
        imageView.image = UIImage(named: imageName)
        imageView.alpha = CGFloat(imageAlpha)
    }
    
    func getDefaults() {
        redSlider.value = userDefaults.floatForKey("red")
        changeBackgroundColor(redSlider)

        greenSlider.value = userDefaults.floatForKey("green")
        changeBackgroundColor(greenSlider)

        blueSlider.value = userDefaults.floatForKey("blue")
        changeBackgroundColor(blueSlider)
        
        imageSegmentedControl.selectedSegmentIndex = userDefaults.integerForKey("image")
        selectImage(imageSegmentedControl)
        
        alphaStepper.value = userDefaults.doubleForKey("alpha")
        changeImageTransparency(alphaStepper)
        
        showBackgroundSwitch.on = userDefaults.boolForKey("hidden")
        showBackground(showBackgroundSwitch)
    }
}

