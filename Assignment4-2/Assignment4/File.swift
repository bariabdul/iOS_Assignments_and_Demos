//
//  File.swift
//  Assignment4
//
//  Created by Bari Abdul and Abdul Subhan Moin Syed on 11/5/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//
import UIKit;
import Foundation;

//this swift file is used to support portrait upside down orientation
class Rotate: UISplitViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
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