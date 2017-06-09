//
//  DetailViewController.swift
//  MCU
//
//  Created by Kurt McMahon on 10/13/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var allegianceLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    var detailItem: MCUCharacter? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let imageView = self.characterImageView {
                ImageProvider.sharedInstance.imageWithURLString(detail.url) {
                    (image) in
                    imageView.image = image
                }
            }
            if let label = self.nameLabel {
                label.text = detail.name
            }
            if let label = self.realNameLabel {
                label.text = detail.realName
            }
            if let label = self.allegianceLabel {
                label.text = detail.allegiance
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


}

