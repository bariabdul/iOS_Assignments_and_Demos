//
//  Calendar.swift
//  Assignment3
//
//  Created by Bari Abdul on 10/28/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class Calendar: UIViewController {

    
    //declare the necessary outlets and labels and buttons
    @IBOutlet weak var minDate: UIDatePicker!
    @IBOutlet weak var maxDate: UIDatePicker!
    
    
    @IBAction func computeDays(sender: UIButton) {
        //let startDate = NSDate()
        
    }
    
    
    @IBOutlet weak var daysLabel: UILabel!
    
    
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
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
}