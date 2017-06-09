//
//  PresidentCell.swift
//  Assignment4
//
//  Created by Bari Abdul and Abdul Subhan Moin Syed on 11/17/16.
//  Copyright © 2016 Bari Abdul. All rights reserved.
//

import UIKit

class PresidentCell: UITableViewCell {
    
    //these outlets are to make these image views and labels to appear on the master view within each cell
    
    @IBOutlet weak var presidentImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var politicalPartyLabel: UILabel!
    
        
        override func awakeFromNib() {
            super.awakeFromNib()
            //Initialization code
        }
        
        
        override func setSelected(selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            //Configure the view for the selected state
        }


}
