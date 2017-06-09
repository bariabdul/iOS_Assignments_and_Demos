//
//  ViewController.swift
//  Scroller
//
//  Created by Kurt McMahon on 9/25/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theScroller: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //theScroller.contentSize = CGSizeMake(320.0, 2000.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

