//
//  MCUCharacterCell.swift
//  MCU
//
//  Created by Kurt McMahon on 11/7/16.
//  Copyright © 2016 Northern Illinois University. All rights reserved.
//

import UIKit

class MCUCharacterCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var allegianceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
