//
//  File.swift
//  Assignment3
//
//  Created by Bari Abdul on 10/26/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import Foundation;
import UIKit;
class Rotate: UITabBarController {      //this swift file is especially written for allowing the user to rotate the app in all directions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //this code is used for having all kinds of orientations including the upside down
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return.All
    }
    
}
