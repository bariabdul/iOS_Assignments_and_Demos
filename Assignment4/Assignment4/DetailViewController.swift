//
//  DetailViewController.swift
//  Assignment4
//
//  Created by Bari Abdul on 11/2/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //point out all the labels from main.storyboard
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tenureLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var politicalPartyLabel: UILabel!

    
    var detailItem: President? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.nameLabel {
                label.text = detail.name
            }
            
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.OrdinalStyle
            
            let final = formatter.stringFromNumber(detail.number)!
            if let label = self.numberLabel {
                label.text = "\(final) President of the United States"
            }
            
            if let label = self.tenureLabel {
                label.text = "(\(detail.startDate) to \(detail.endDate))"
            }
            
            if let label = self.nicknameLabel {
                label.text = "\(detail.nickname)"
            }
            
            if let label = self.politicalPartyLabel {
                label.text = "\(detail.politicalParty)"
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
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

