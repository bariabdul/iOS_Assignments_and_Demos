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
    
    var backgroundRed: CGFloat = 0 {
        didSet {
            configureView()
        }
    }

    var backgroundGreen: CGFloat = 0 {
        didSet {
            configureView()
        }
    }
    var backgroundBlue: CGFloat = 0 {
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

    var imageAlpha: CGFloat = 1 {
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
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Actions
    
    // Change RGB values for backgroundView
    @IBAction func changeBackgroundColor(sender: UISlider) {
        if sender == redSlider {
            backgroundRed = CGFloat(sender.value)
        } else if sender == greenSlider {
            backgroundGreen = CGFloat(sender.value)
        } else {
            backgroundBlue = CGFloat(sender.value)
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
    }
    
    @IBAction func changeImageTransparency(sender: UIStepper) {
        imageAlpha = CGFloat(sender.value)
    }
    
    @IBAction func showBackground(sender: UISwitch) {
        backgroundHidden = !sender.on
    }
    
    // Update user interface to reflect new model values
    func configureView() {
        backgroundView.backgroundColor = UIColor(red: backgroundRed, green: backgroundGreen, blue: backgroundBlue, alpha: 1)
        backgroundView.hidden = backgroundHidden
        imageView.image = UIImage(named: imageName)
        imageView.alpha = imageAlpha
    }

}

